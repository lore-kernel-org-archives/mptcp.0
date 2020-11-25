Content-Type: multipart/mixed; boundary="===============3432593467672107247=="
MIME-Version: 1.0
From: Othman, Ossama <ossama.othman at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Address ID assignment in netlink PM
Date: Wed, 25 Nov 2020 21:48:22 +0000
Message-ID: <e8943d8b731245c5952890dec805fa65@intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6941

--===============3432593467672107247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

While debugging a netlink PM "get addr" issue I was having in mptcpd I foun=
d that the address ID assigned by mptcpd was being overridden by the kernel=
.  Based on the code in pm_nl_ctl.c in the MPTCP self tests, and the code i=
n pm_netlink.c in the kernel, the MPTCP_PM_CMD_ADD_ADDR command accepts an =
optional address ID attribute.  When that attribute is available the ID is =
stored in the corresponding mptcp_pm_addr_entry instance by mptcp_pm_parse_=
addr():

	if (tb[MPTCP_PM_ADDR_ATTR_ID])
		entry->addr.id =3D nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);

However, that value is later overridden in mptcp_pm_nl_append_new_local_add=
r():

	entry->addr.id =3D pernet->next_id++;

That causes the userspace to lose track of an address it added with a speci=
fic ID, at which point the only way to find out the new ID is to dump the a=
ddrs to find the new ID corresponding to local address in question.  Is thi=
s the intended behavior?  It seems like userspace- and kernel-based address=
 ID assignment should be mutually exclusive.  Otherwise we run into this so=
rt of scenario.  Is there a need for the kernel to assign IDs in the netlin=
k PM case?

Please let me know if I'm misunderstanding how ID assignment is expected to=
 work when using the netlink PM.

Thanks for your help!
-Ossama

--===============3432593467672107247==--
