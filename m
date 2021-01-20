Content-Type: multipart/mixed; boundary="===============6262615247333656166=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 2/7] mptcp: move pm netlink work into
 pm_netlink
Date: Tue, 19 Jan 2021 16:27:52 -0800
Message-ID: <afb06ec6-793f-81d3-733c-fc115f9b30b1@linux.intel.com>
In-Reply-To: 20210114173654.7618-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7431

--===============6262615247333656166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Jan 2021, Florian Westphal wrote:

> allows to make some functions static and avoids aquire of the pm spinlock
> in protocol.c.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/pm_netlink.c | 45 +++++++++++++++++++++++++++++++++++++-----
> net/mptcp/protocol.c   | 33 +------------------------------
> net/mptcp/protocol.h   |  6 +-----
> 3 files changed, 42 insertions(+), 42 deletions(-)
>

Also ok with me to apply this to the export branch.

--
Mat Martineau
Intel
--===============6262615247333656166==--
