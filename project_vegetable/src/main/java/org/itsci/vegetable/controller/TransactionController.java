package org.itsci.vegetable.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.itsci.vegetable.model.Assets;
import org.itsci.vegetable.model.Logins;
import org.itsci.vegetable.model.Member;
import org.itsci.vegetable.model.Register;
import org.itsci.vegetable.model.Transaction;
import org.itsci.vegetable.model.Transaction_details;
import org.itsci.vegetable.dao.MemberManager;
import org.itsci.vegetable.dao.RegisterManager;
import org.itsci.vegetable.dao.TransactionManager;

@Controller
public class TransactionController {

	/* listAll */
	@RequestMapping(value = "/goListall", method = RequestMethod.GET)
	public String goListall(HttpServletRequest request, HttpSession session) {

		// Logins log = (Logins) session.getAttribute("login");
		MemberManager lmem = new MemberManager();
		// System.out.println(log.getMember().getMember_id());
		// Member listmember = lmem.getMember(log.getMember().getMember_id());

		// session.setAttribute("member", listmember);
		return "listIncomeandExpense";
	}

	/* goEdit_income_expense */
	@RequestMapping(value = "/goEdit_income_expense", method = RequestMethod.GET)
	public String goEdit_income_expense(HttpServletRequest request, HttpSession session) {
		String type = request.getParameter("type");
		String date = request.getParameter("date");
		TransactionManager tm = new TransactionManager();
		// tm.list_transaction_details(Integer.valueOf(td));
		List<Transaction_details> list_edit = tm.transaction_details_by_date(type, date);

		session.setAttribute("list_edit", list_edit);

		return "editIncomeExpense";
	}

	/* edit_income_expense */
	@RequestMapping(value = "/edit_income_expense", method = RequestMethod.GET)
	public String edit_income_expense(HttpServletRequest request, HttpSession session) {
		String asid = request.getParameter("asid");
		String tid = request.getParameter("tid");
		String tdid = request.getParameter("tdid");
		TransactionManager tm = new TransactionManager();

		System.out.println(asid + " " + tid + " " + tdid);

		Transaction_details tran_de_id = tm.transaction_details_id(Integer.parseInt(tdid), Integer.parseInt(tid));
		String go = "";

		session.setAttribute("tran_de_id", tran_de_id);
		if (tran_de_id.getType().equals("สินค้า")) {
			go = "editIncome";
		} else {
			go = "editExpense";
		}
		return go;

	}

	/* edit_income */
	@RequestMapping(value = "/edit_income", method = RequestMethod.POST)
	public String edit_income(HttpServletRequest request, HttpSession session) {
		Double sum = Double.parseDouble(request.getParameter("sum"));
		int amount = Integer.parseInt(request.getParameter("amount"));
		int tdid = Integer.parseInt(request.getParameter("tdid"));
		int tid = Integer.parseInt(request.getParameter("tid"));
		TransactionManager tm = new TransactionManager();
		Transaction t = tm.transactionID(tid);
		Assets a = new Assets();

		Transaction_details td = new Transaction_details(tdid, "", amount, sum, t, a);

		tm.editIncome(td);

		return "editIncomeExpense";
	}

	/* edit_expense */
	@RequestMapping(value = "/edit_expense", method = RequestMethod.POST)
	public String edit_expense(HttpServletRequest request, HttpSession session) {
		Double sum = Double.parseDouble(request.getParameter("sum"));
		int amount = Integer.parseInt(request.getParameter("amount"));
		int tdid = Integer.parseInt(request.getParameter("tdid"));
		int tid = Integer.parseInt(request.getParameter("tid"));
		String type = request.getParameter("type");
		TransactionManager tm = new TransactionManager();
		Transaction t = tm.transactionID(tid);
		t.setTotal_price(sum);
		Assets a = new Assets();

		Transaction_details td = new Transaction_details(tdid, type, amount, sum, t, a);

		tm.editExpense(td);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<Transaction_details> list_edit = tm.transaction_details_by_date(td.getType(),
				sdf.format(td.getTransaction().getDate_time().getTime()));
		session.setAttribute("list_edit", list_edit);

		return "editIncomeExpense";
	}

	/* add income */
	@RequestMapping(value = "/goaddIncome", method = RequestMethod.GET)
	public String goaddIncome(HttpServletRequest request, HttpSession session) {

		Logins log = (Logins) session.getAttribute("login");
		MemberManager lmem = new MemberManager();
		System.out.println(log.getMember().getMember_id());
		Member listmember = lmem.getMember(log.getMember().getMember_id());

		session.setAttribute("member", listmember);
		return "addincome";

	}

	@RequestMapping(value = "/addIncome", method = RequestMethod.POST)
	public String addIncome(HttpServletRequest request, HttpSession session) {
		Logins log = (Logins) session.getAttribute("login");
		MemberManager lmem = new MemberManager();
		Member member = lmem.getMember(log.getMember().getMember_id());

		/* ไอดี */
		int tsid = (int) (System.currentTimeMillis() / 1000);
		// String tsdgid = "r"+Long.toString(unix);

		int asset_id = Integer.parseInt(request.getParameter("product_name"));
		String asset_price = request.getParameter("asset_price");
		int amount = Integer.parseInt(request.getParameter("amount"));
		Double sum = Double.parseDouble(request.getParameter("sum"));

		Calendar date = Calendar.getInstance();
		String term;
		if (date.get(Calendar.MONTH) + 1 >= 7 && date.get(Calendar.MONTH) + 1 <= 10) {
			term = "1";
		} else {
			term = "2";
		}
		Transaction tc = new Transaction(tsid, date, sum, term, member);

		TransactionManager t = new TransactionManager();
		t.addincome_transaction(tc);

		Assets as = t.assetID(asset_id);
		Transaction_details tsd = new Transaction_details(1, "สินค้า", amount, sum, tc, as);
		t.addincome_tsac_detail(tsd);
		return "addincome";
	}
	/* end addincome */

	/* add expense */
	@RequestMapping(value = "/goaddExpense", method = RequestMethod.GET)
	public String goaddExpense(HttpServletRequest request, HttpSession session) {

		Logins log = (Logins) session.getAttribute("login");
		MemberManager lmem = new MemberManager();
		System.out.println(log.getMember().getMember_id());
		Member listmember = lmem.getMember(log.getMember().getMember_id());

		session.setAttribute("member", listmember);
		return "addexpense";

	}

	@RequestMapping(value = "/addExpense", method = RequestMethod.POST)
	public String addExpense(HttpServletRequest request, HttpSession session) {
		Logins log = (Logins) session.getAttribute("login");
		MemberManager lmem = new MemberManager();
		Member member = lmem.getMember(log.getMember().getMember_id());

		/* ไอดี */
		int tsid = (int) (System.currentTimeMillis() / 1000);
		// String tsdgid = "r"+Long.toString(unix);

		int asset_id = Integer.parseInt(request.getParameter("equipment_name"));
		String asset_price = request.getParameter("asset_price");
		int amount = Integer.parseInt(request.getParameter("amount"));
		Double sum = Double.parseDouble(request.getParameter("sum"));

		Calendar date = Calendar.getInstance();
		String term;
		if (date.get(Calendar.MONTH) + 1 >= 7 && date.get(Calendar.MONTH) + 1 <= 10) {
			term = "1";
		} else {
			term = "2";
		}
		Transaction tc = new Transaction(tsid, date, sum, term, member);

		TransactionManager t = new TransactionManager();
		t.addExpense_transaction(tc);

		Assets as = t.assetID(asset_id);
		Transaction_details tsd = new Transaction_details(1, "อุปกรณ์", amount, sum, tc, as);
		t.addExpense_tsac_detail(tsd);

		return "addexpense";
	}

	@RequestMapping(value = "/search_income_expense", method = { RequestMethod.POST, RequestMethod.GET })
	public String search_income_expense(HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {
		}
		String yearterm = request.getParameter("term_year");
		String term;
		String y;

		if (yearterm == null || yearterm.isEmpty() || yearterm.equals("")) {
			term = "";
			y = "";
		} else {
			String yeartermArray[] = yearterm.split("-");
			term = yeartermArray[0];
			y = yeartermArray[1];
		}
		String date = request.getParameter("date");
		String new_date = "";
		if (date == null || date.isEmpty()) {
			date = "";
		} else {/* แปลงวันที่ */
			String date1[] = date.split("-");
			/* เปลี่ยน ค.ศ -> พ.ศ */
			int year = Integer.parseInt(date1[0]) + 543;
			new_date = date.replace(date1[0], String.valueOf(year));
		}
		String type = request.getParameter("type");
		if (type == null) {
			type = "1";
		}

		TransactionManager t = new TransactionManager();
		List<Transaction_details> listtran = t.Alltransaction_by_search(term, y);
		List<Transaction_details> list_details = t.transaction_details_by_search(type, new_date, term, y);
		if (date.equals("")) {
			if (type.equals("1")) {
				listtran = t.Alltransaction_by_search(term, y);
			} else {
				listtran = t.transaction_by_search(type, new_date, term, y);
			}
		} else {
			if (type.equals("1")) {
				listtran = t.transaction_by_search(type, new_date, term, y);
				list_details = t.Alltransaction_details_by_search(new_date, term, y);
			} else {
				listtran = t.transaction_by_search(type, new_date, term, y);
				list_details = t.transaction_details_by_search(type, new_date, term, y);
			}
		}

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (!date.equals("")) {
			String date1[] = date.split("-");
			int year = Integer.parseInt(date1[0]);
			cal.set(year, Integer.parseInt(date1[1]) - 1, Integer.parseInt(date1[2]));
			new_date = sdf.format(cal.getTime());
		}
		request.setAttribute("ListTran", listtran);
		request.setAttribute("list_details", list_details);
		request.setAttribute("term_year", yearterm);
		request.setAttribute("type", type);
		request.setAttribute("new_date", new_date);
		return "listIncomeandExpense";

	}

	/* delete_all */
	@RequestMapping(value = "/delete_income_expense", method = RequestMethod.GET)
	public String delete_income_expense(HttpServletRequest request, HttpSession session) {

		String date = request.getParameter("date");

		TransactionManager tm = new TransactionManager();

		tm.delete_income_expense(date);

		return "listIncomeandExpense";
	}

	/* delete_column */
	@RequestMapping(value = "/delete_Colume_income_expense", method = RequestMethod.GET)
	public String delete_column_income_expense(HttpServletRequest request, HttpSession session) {

		String tid = request.getParameter("tid");
		String type = request.getParameter("type");
		String date = request.getParameter("date");

		TransactionManager tm = new TransactionManager();

		tm.delete_column_income_expense(tid);

		List<Transaction_details> list_edit = tm.transaction_details_by_date(type, date);
		session.setAttribute("list_edit", list_edit);

		if (list_edit.size() == 0 || list_edit == null) {
			return "listIncomeandExpense";
		} else {
			return "editIncomeExpense";
		}

	}
}
