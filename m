Content-Type: multipart/mixed; boundary="===============8268389309381586409=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 01/15] tcp md5sig: Use skb's saddr when replying
 to an incoming segment
Date: Tue, 12 Dec 2017 16:01:05 -0800
Message-ID: <alpine.OSX.2.21.1712121600240.15459@sjweber-mobl.amr.corp.intel.com>
In-Reply-To: 20171211214218.35868-2-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 250

--===============8268389309381586409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 11 Dec 2017, Christoph Paasch wrote:

> The MD5-key that belongs to a connection is identified by the peer's
> IP-address. When we are in tcp_v4(6)_reqsk_send_ack(), we are replying
> to an incoming segment from tcp_check_req() that failed the seq-number
> checks.
>
> Thus, to find the correct key, we need to use the skb's saddr and not
> the daddr.
>
> This bug seems to have been there since quite a while, but probably got
> unnoticed because the consequences are not catastrophic. We will call
> tcp_v4_reqsk_send_ack only to send a challenge-ACK back to the peer,
> thus the connection doesn't really fail.
>
> Fixes: 9501f9722922 ("tcp md5sig: Let the caller pass appropriate key for=
 tcp_v{4,6}_do_calc_md5_hash().")
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>

I saw that this was merged on netdev already. Thumbs up!

--
Mat Martineau
Intel OTC

--===============8268389309381586409==--
