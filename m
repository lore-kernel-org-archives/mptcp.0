Content-Type: multipart/mixed; boundary="===============0483829744962269186=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 4/4] mptcp: introduce token KUNIT
 self-tests
Date: Fri, 26 Jun 2020 14:26:08 -0700
Message-ID: <alpine.OSX.2.23.453.2006261425520.66996@redsall-mobl2.amr.corp.intel.com>
In-Reply-To: 592538b2c28ee849ff94d9cfc8f7f6dbc5adae5d.1593192442.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4836

--===============0483829744962269186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 26 Jun 2020, Paolo Abeni wrote:

> Unit tests for the internal MPTCP token APIs, using KUNIT
>
> v1 -> v2:
> - use the correct RCU annotation when initializing icsk ulp
> - fix a few checkpatch issues
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/Kconfig      |   2 +-
> net/mptcp/Makefile     |   3 +-
> net/mptcp/token.c      |   9 +++
> net/mptcp/token_test.c | 140 +++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 152 insertions(+), 2 deletions(-)
> create mode 100644 net/mptcp/token_test.c

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============0483829744962269186==--
