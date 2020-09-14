Content-Type: multipart/mixed; boundary="===============2161768831742119090=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 11/13] mptcp: allow picking different
 xmit subflows
Date: Mon, 14 Sep 2020 11:09:21 -0700
Message-ID: <alpine.OSX.2.23.453.2009141109020.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: e676b2a4b3de838d458353e9f860a2fd4e1a9e35.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5859

--===============2161768831742119090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> Update the scheduler to less trivial heuristic: cache
> the last used subflow, and try to send on it a reasonably
> long burst of data.
>
> When the burst or the subflow send space is exhausted, pick
> the subflow with the lower ratio between write space and
> send buffer - that is, the subflow with the greater relative
> amount of free space.
>
> v1 -> v2:
> - fix 32 bit build breakage due to 64bits div
> - fix checkpath issues (uint64_t -> u64)
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 111 ++++++++++++++++++++++++++++++++++++-------
> net/mptcp/protocol.h |   6 ++-
> 2 files changed, 99 insertions(+), 18 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2161768831742119090==--
