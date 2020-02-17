Content-Type: multipart/mixed; boundary="===============2182272170315564497=="
MIME-Version: 1.0
From: Dan Carpenter <dan.carpenter at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [bug report] mptcp: Implement MPTCP receive path
Date: Mon, 17 Feb 2020 17:52:15 +0300
Message-ID: <20200217145214.sfn76fqgt6ixo5sw@kili.mountain>
X-Status: 
X-Keywords:                  
X-UID: 3668

--===============2182272170315564497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

The patch 648ef4b88673: "mptcp: Implement MPTCP receive path" from
Jan 21, 2020, leads to the following static checker warning:

	net/mptcp/subflow.c:558 subflow_data_ready()
	warn: test_bit() takes a bit number

net/mptcp/subflow.c
   544  static void subflow_data_ready(struct sock *sk)
   545  {
   546          struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx=
(sk);
   547          struct sock *parent =3D subflow->conn;
   548  =

   549          if (!parent || !subflow->mp_capable) {
   550                  subflow->tcp_data_ready(sk);
   551  =

   552                  if (parent)
   553                          parent->sk_data_ready(parent);
   554                  return;
   555          }
   556  =

   557          if (mptcp_subflow_data_available(sk)) {
   558                  set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
                                ^^^^^^^^^^^^^^^^
This is "BIT(0)" but it should just be "0".  The double shift bug will
not cause a problem so long as it is done consistently and it doesn't go
higher than BIT(6).

   559  =

   560                  parent->sk_data_ready(parent);
   561          }
   562  }

See also:

net/mptcp/subflow.c:558 subflow_data_ready() warn: test_bit() takes a bit n=
umber
net/mptcp/subflow.c:571 subflow_write_space() warn: test_bit() takes a bit =
number
net/mptcp/subflow.c:694 subflow_state_change() warn: test_bit() takes a bit=
 number
net/mptcp/protocol.c:261 ssk_check_wmem() warn: test_bit() takes a bit numb=
er
net/mptcp/protocol.c:361 mptcp_wait_data() warn: test_bit() takes a bit num=
ber
net/mptcp/protocol.c:361 mptcp_wait_data() warn: test_bit() takes a bit num=
ber
net/mptcp/protocol.c:504 mptcp_recvmsg() warn: test_bit() takes a bit number
net/mptcp/protocol.c:505 mptcp_recvmsg() warn: test_bit() takes a bit number
net/mptcp/protocol.c:507 mptcp_recvmsg() warn: test_bit() takes a bit number
net/mptcp/protocol.c:514 mptcp_recvmsg() warn: test_bit() takes a bit number
net/mptcp/protocol.c:874 mptcp_memory_free() warn: test_bit() takes a bit n=
umber
net/mptcp/protocol.c:1090 mptcp_poll() warn: test_bit() takes a bit number
net/mptcp/protocol.c:1093 mptcp_poll() warn: test_bit() takes a bit number

regards,
dan carpenter
--===============2182272170315564497==--
