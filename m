Content-Type: multipart/mixed; boundary="===============2363235144197393050=="
MIME-Version: 1.0
From: Dan Carpenter <dan.carpenter at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [bug report] mptcp: retransmit ADD_ADDR when timeout
Date: Mon, 09 Nov 2020 12:33:25 +0300
Message-ID: <20201109093325.GA2451633@mwanda>
X-Status: 
X-Keywords:                  
X-UID: 6590

--===============2363235144197393050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Geliang Tang,

This is a semi-automatic email about new static checker warnings.

The patch 00cfd77b9063: "mptcp: retransmit ADD_ADDR when timeout"
from Sep 24, 2020, leads to the following Smatch complaint:

    net/mptcp/pm_netlink.c:213 mptcp_pm_add_timer()
    warn: variable dereferenced before check 'msk' (see line 208)

net/mptcp/pm_netlink.c
   207		struct mptcp_sock *msk =3D entry->sock;
   208		struct sock *sk =3D (struct sock *)msk;
   209		struct net *net =3D sock_net(sk);
                                           ^^
"msk" dereferenced here.

   210	=

   211		pr_debug("msk=3D%p", msk);
   212	=

   213		if (!msk)
                    ^^^^
Too late.

   214			return;
   215	=


regards,
dan carpenter
--===============2363235144197393050==--
