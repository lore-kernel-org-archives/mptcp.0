Content-Type: multipart/mixed; boundary="===============3037748182537695498=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: push pending frames when
 subflow has free space
Date: Wed, 09 Dec 2020 17:42:04 -0800
Message-ID: <306ee763-731-c88c-97f0-b9fb28f8a31d@linux.intel.com>
In-Reply-To: 41eec9f439fdbe2ae5549f6222af4b24f58c0af5.1607535998.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7118

--===============3037748182537695498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 9 Dec 2020, Paolo Abeni wrote:

> When multiple subflows are active, we can receive a
> window update on subflow with no write space available.
> MPTCP will try to push frames on such subflow and will
> fail. Pending frames will be pushed only after receiving
> a window update on a subflow with some wspace available.
>
> Overall the above could lead to suboptimal aggregate
> bandwidth usage.
>
> Instead, we should try to push pending frames as soon as
> the subflow reaches both conditions mentioned above.
>
> We can finally enable self-tests with asymmetric links,
> as the above makes them finally pass.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/options.c                               | 13 ++++++++-----
> net/mptcp/protocol.c                              |  2 +-
> net/mptcp/protocol.h                              |  2 +-
> tools/testing/selftests/net/mptcp/simult_flows.sh |  6 +++---
> 4 files changed, 13 insertions(+), 10 deletions(-)

Hi Paolo -

Looks good!

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3037748182537695498==--
