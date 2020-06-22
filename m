Content-Type: multipart/mixed; boundary="===============8951114549819130677=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2] mptcp: drop sndr_key in mptcp_syn_options
Date: Mon, 22 Jun 2020 13:50:00 +0200
Message-ID: <1c0f6f37-ede8-b341-f274-2b65b17dc141@tessares.net>
In-Reply-To: 60f8315d6ae7b62d175c573f75cee50f14ce988b.1592826171.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4768

--===============8951114549819130677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 22/06/2020 13:45, Geliang Tang wrote:
> In RFC 8684, we don't need to send sndr_key in SYN package anymore, so dr=
op

Please next time try to have max 72 chars per line in your commit message ;)

> it.
> =

> Fixes: cc7972ea1932 ("mptcp: parse and emit MP_CAPABLE option according t=
o v1 spec")
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Thank you for this v2. It looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8951114549819130677==--
