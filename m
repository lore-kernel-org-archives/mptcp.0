Content-Type: multipart/mixed; boundary="===============7850301712847684554=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 02/10] mptcp: token: remove two unneeded
 helpers
Date: Tue, 27 Aug 2019 19:32:13 +0200
Message-ID: <20190827173213.GB20113@breakpoint.cc>
In-Reply-To: 56c025d7-b7ec-c34b-8b7f-30784c661f5f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1718

--===============7850301712847684554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:

[ WARN_ON_ONCE ]

> Why do we need to do this check after each lookup?

Good point, I'll remove it in v2.

Its a leftover -- i saw a crash in sock_release(),
and guessed it was because it tried to release the "token_used"
dummy -- some places test for NULL, others also for
conn =3D=3D &token_used.

I couldn't reproduce it yet and added these WARN to
see if that is the case or not...)

--===============7850301712847684554==--
