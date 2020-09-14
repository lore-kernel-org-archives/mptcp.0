Content-Type: multipart/mixed; boundary="===============3125163933957532727=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 08/13] mptcp: add OoO related mibs
Date: Mon, 14 Sep 2020 11:08:06 -0700
Message-ID: <alpine.OSX.2.23.453.2009141107500.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: a968da10355e303d483a9d12409930e80ab7fccd.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5856

--===============3125163933957532727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> Add a bunch of MPTCP mibs related to MPTCP OoO data
> processing.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/mib.c      |  5 +++++
> net/mptcp/mib.h      |  5 +++++
> net/mptcp/protocol.c | 24 +++++++++++++++++++++++-
> net/mptcp/subflow.c  |  1 +
> 4 files changed, 34 insertions(+), 1 deletion(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3125163933957532727==--
