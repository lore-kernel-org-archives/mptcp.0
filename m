Content-Type: multipart/mixed; boundary="===============6826345360596992360=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 1/7] mptcp: mptcp: update mptcp ack
 sequence outside of recv path
Date: Tue, 25 Feb 2020 17:52:07 -0800
Message-ID: <alpine.OSX.2.22.394.2002251746510.39325@tvtrimel-mobl2.amr.corp.intel.com>
In-Reply-To: 20200225171659.4807-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3802

--===============6826345360596992360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 25 Feb 2020, Florian Westphal wrote:

> Changes since v1:
> - in patch 6, need READ_ONCE() when reading ->owner.
>  in mptcp_data_ready, call sk->sk_data_ready(sk) to wake up
>  the user last.  Also update the commit message.
>
> This helps specifically when using blocking i/o:
> sk->sk_data_ready(sk) wakes up the sleeping process that waited
> for data, best if we can update the mptcp receive queue before it.
>
> - Squashed the last two patches.
>
> I plan to send this to netdev@ wednesday morning CET.

Thanks Florian & Paolo, this is a big improvement. Series looks ready for =

netdev.

--
Mat Martineau
Intel
--===============6826345360596992360==--
