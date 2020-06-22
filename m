Content-Type: multipart/mixed; boundary="===============8226521332177386563=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: drop sndr_key in mptcp_syn_options
Date: Mon, 22 Jun 2020 13:33:47 +0200
Message-ID: <2776de97-5f55-faae-c02d-4f0d4dfa0df8@tessares.net>
In-Reply-To: 4e452a1ba52065633cb45d844af2e998176a6121.1592823756.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4766

--===============8226521332177386563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

Thank you for the patch!

On 22/06/2020 13:09, Geliang Tang wrote:
> In RFC 8684, we don't need to send sndr_key in SYN package anymore, so dr=
op it.

Good catch, it is no longer needed there.

But please wrap your commit message after max 72 chars.
I guess you know there are exceptions like for the Fixes tag, etc. More =

info by running checkpatch.pl.

> Fixes: cec37a6e41aae ("mptcp: Handle MP_CAPABLE options for outgoing conn=
ections")

When this commit was pushed, only MPTCPv0 (RFC 6824) was supported.
I guess you can do a reference to this one:

     Fixes: cc7972ea1932 ("mptcp: parse and emit MP_CAPABLE option =

according to v1 spec")

Since this commit, we no longer need sndr_key for the SYN.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8226521332177386563==--
