Content-Type: multipart/mixed; boundary="===============1152435417900334632=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 07/13] mptcp: cleanup
 mptcp_subflow_discard_data()
Date: Mon, 14 Sep 2020 11:07:46 -0700
Message-ID: <alpine.OSX.2.23.453.2009141107280.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: f62a0071f94505b78dd32140b685cd938560008e.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5855

--===============1152435417900334632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> There is no need to use the tcp_read_sock(), we can
> simply drop the skb. Additionally try to look at the
> next buffer for in order data.
>
> This both simplifies the code and avoid unneeded indirect
> calls.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.h |  1 -
> net/mptcp/subflow.c  | 58 +++++++++++---------------------------------
> 2 files changed, 14 insertions(+), 45 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============1152435417900334632==--
