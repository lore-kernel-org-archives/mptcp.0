Content-Type: multipart/mixed; boundary="===============7780758801663632997=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: add missing memory scheduling in the
 rx path
Date: Tue, 27 Oct 2020 15:46:11 -0700
Message-ID: <d7886714-7b92-9be8-441e-73c48c52d62@linux.intel.com>
In-Reply-To: f6143a6193a083574f11b00dbf7b5ad151bc4ff4.1603810630.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6452

--===============7780758801663632997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2020, Paolo Abeni wrote:

> When moving the skbs from the subflow into the msk receive
> queue, we must schedule there the required amount of memory.
>
> Try to borrow the required memory from the subflow, if needed,
> so that we leverage the existing TCP heuristic.
>
> Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============7780758801663632997==--
