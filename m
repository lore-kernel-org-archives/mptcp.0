Content-Type: multipart/mixed; boundary="===============0387310764363578087=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 3/4] mptcp: move crypto test to KUNIT
Date: Fri, 26 Jun 2020 14:25:48 -0700
Message-ID: <alpine.OSX.2.23.453.2006261425220.66996@redsall-mobl2.amr.corp.intel.com>
In-Reply-To: cc66fb0363b7e454cbc4d3d70d1216e7c242908c.1593192442.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4835

--===============0387310764363578087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2020, Paolo Abeni wrote:

> currently MPTCP uses a custom hook to executed unit tests at
> boot time. Let's use the KUNIT framework instead.
> Additionally move the relevant code to a separate file and
> export the function needed by the test when self-tests
> are build as a module.
>
> Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/Kconfig       | 20 ++++++++----
> net/mptcp/Makefile      |  3 ++
> net/mptcp/crypto.c      | 63 ++----------------------------------
> net/mptcp/crypto_test.c | 72 +++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 91 insertions(+), 67 deletions(-)
> create mode 100644 net/mptcp/crypto_test.c

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============0387310764363578087==--
