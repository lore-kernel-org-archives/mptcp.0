Content-Type: multipart/mixed; boundary="===============3037139381491948090=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/3] mptcp: refactor xmit path
Date: Tue, 07 May 2019 18:06:09 +0200
Message-ID: <c85e7b84273a5802ad5aeb05072608df0a4be1f9.camel@redhat.com>
In-Reply-To: cover.1557234490.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1124

--===============3037139381491948090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-05-07 at 15:15 +0200, Paolo Abeni wrote:
> this series refactor the mptcp xmit path trying to make sendmsg behavior
> more consistent, memory efficent and improve its performances.

Self-nack, I just found a bunch of issues testing with latest self-
tests (userland of test-bench was lagging a bit behind the current
git).

Sorry for the noise,

Paolo


--===============3037139381491948090==--
