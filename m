Content-Type: multipart/mixed; boundary="===============7973843644979487758=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 03/13] mptcp: trigger msk processing
 even for OoO data
Date: Mon, 14 Sep 2020 11:03:47 -0700
Message-ID: <alpine.OSX.2.23.453.2009141103170.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: 2a05880d191b0859f52bbcc002cd694603cd36b8.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5851

--===============7973843644979487758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> This is a prerequisite to allow receiving data from multiple
> subflows without re-injection.
>
> Instead of dropping the OoO - "future" data in
> subflow_check_data_avail(), call into __mptcp_move_skbs()
> and let the msk drop that.
>
> To avoid code duplication factor out the mptcp_subflow_discard_data()
> helper.
>
> Note that __mptcp_move_skbs() can now find multiple subflows
> with data avail (comprising to-be-discarded data), so must
> update the byte counter incrementally.
>
> v1 -> v2:
> - fix checkpatch issues (unsigned -> unsigned int)
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 33 +++++++++++++++----
> net/mptcp/protocol.h |  9 ++++-
> net/mptcp/subflow.c  | 78 ++++++++++++++++++++++++--------------------
> 3 files changed, 78 insertions(+), 42 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>


--
Mat Martineau
Intel
--===============7973843644979487758==--
