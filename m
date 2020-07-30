Content-Type: multipart/mixed; boundary="===============0177341466615655578=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC v3 08/10] mptcp: enable JOIN requests even if
 cookies are in use
Date: Thu, 30 Jul 2020 02:17:37 +0200
Message-ID: <20200730001737.GB5271@breakpoint.cc>
In-Reply-To: 20200730001241.3037-9-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5383

--===============0177341466615655578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Florian Westphal <fw(a)strlen.de> wrote:
> JOIN requests do not work in syncookie mode -- for HMAC validation, the
> peers nonce and the mptcp token (to obtain the desired connection socket
> the join is for) are required, but this information is only present in the
> initial syn.
> =

> So either we need to drop all JOIN requests once a listening socket enters
> syncookie mode, or we need to store enough state to reconstruct the reque=
st
> socket later.
> =

> This allows the subflow request initialisation function to store the
> request socket even when syncookies are used, i.e. the listener
> socket queue will grow past its upper limit.

Hmpf, forgot to adjust the commit message to reflect the changes
suggested by Paolo.

I've fixed this up locally.

--===============0177341466615655578==--
