Content-Type: multipart/mixed; boundary="===============3904005410793665128=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 15/25] tcp_extra_options: Skip fast-path when
 extra-options are present
Date: Mon, 27 Nov 2017 21:57:16 -0800
Message-ID: <20171128055726.430-16-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 190

--===============3904005410793665128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7acc1f46641c..c2ef1309e877 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5333,6 +5333,10 @@ void tcp_rcv_established(struct sock *sk, struct sk_=
buff *skb,
 =

 	tp->rx_opt.saw_tstamp =3D 0;
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled) &&
+	    !list_empty(&tp->tcp_option_list))
+		goto slow_path;
+
 	/*	pred_flags is 0xS?10 << 16 + snd_wnd
 	 *	if header_prediction is to be made
 	 *	'S' will always be tp->tcp_header_len >> 2
-- =

2.15.0


--===============3904005410793665128==--
