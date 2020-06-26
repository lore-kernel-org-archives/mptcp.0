Content-Type: multipart/mixed; boundary="===============6410654302446135486=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 4/4] mptcp: introduce token KUNIT
 self-tests
Date: Fri, 26 Jun 2020 18:46:50 +0200
Message-ID: <20013c7fa42802ec9029a05cdc59dca7bcb51c59.camel@redhat.com>
In-Reply-To: 20200626090238.6914222a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 4822

--===============6410654302446135486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2020-06-26 at 09:02 -0700, Jakub Kicinski wrote:
> On Fri, 26 Jun 2020 12:12:49 +0200 Paolo Abeni wrote:
> > Unit tests for the internal MPTCP token APIs, using KUNIT
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> =

> Greetings! W=3D1 C=3D1 sayeth:
> =

> net/mptcp/token.c:318:6: warning: no newline at end of file
> net/mptcp/token_test.c:139:22: warning: no newline at end of file
> net/mptcp/token_test.c:68:29: warning: incorrect type in assignment (diff=
erent address spaces)
> net/mptcp/token_test.c:68:29:    expected void [noderef] __rcu *icsk_ulp_=
data
> net/mptcp/token_test.c:68:29:    got struct mptcp_subflow_context *ctx

Thank you for checking! =


v2 is coming.

Cheers,

Paolo

--===============6410654302446135486==--
