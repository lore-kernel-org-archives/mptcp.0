Content-Type: multipart/mixed; boundary="===============2334183638590166012=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 4/4] mptcp: introduce token KUNIT
 self-tests
Date: Fri, 26 Jun 2020 09:02:38 -0700
Message-ID: <20200626090238.6914222a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 848d6611c87790a6e4028b856e7c3323a53f2679.1593159603.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4819

--===============2334183638590166012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2020 12:12:49 +0200 Paolo Abeni wrote:
> Unit tests for the internal MPTCP token APIs, using KUNIT
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Greetings! W=3D1 C=3D1 sayeth:

net/mptcp/token.c:318:6: warning: no newline at end of file
net/mptcp/token_test.c:139:22: warning: no newline at end of file
net/mptcp/token_test.c:68:29: warning: incorrect type in assignment (differ=
ent address spaces)
net/mptcp/token_test.c:68:29:    expected void [noderef] __rcu *icsk_ulp_da=
ta
net/mptcp/token_test.c:68:29:    got struct mptcp_subflow_context *ctx
--===============2334183638590166012==--
