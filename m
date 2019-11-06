Content-Type: multipart/mixed; boundary="===============7475144389288358097=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Add DATA_FIN transmission and handling
Date: Wed, 06 Nov 2019 10:29:23 +0100
Message-ID: <20191106092923.GN876@breakpoint.cc>
In-Reply-To: 20191106045011.10071-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2422

--===============7475144389288358097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>  * A DATA_FIN that arrives on a packet without data payload (unless it's
>    a TCP FIN) are discarded by tcp_data_queue() and not propagated to
>    the MPTCP socket. This is detected in mptcp_incoming_options() but
>    not yet handled. The skb with the DATA_FIN could be cloned and
>    placed in the subflow error queue, or a workqueue could handle it.

I have a pending patch that adds an ack workqueue to deal with the
case where we get an mptcp ack for an mptcp socket that has exceeded
its wmem limit, it can be reused for this too.

I'll send it soon.
--===============7475144389288358097==--
