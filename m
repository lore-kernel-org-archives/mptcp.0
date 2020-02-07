Content-Type: multipart/mixed; boundary="===============2295668444966135037=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Protect subflow socket options before
 connection completes
Date: Fri, 07 Feb 2020 13:13:33 -0800
Message-ID: <alpine.OSX.2.22.394.2002071312350.55785@adstraw-mobl1.amr.corp.intel.com>
In-Reply-To: 20200207211055.78411-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3600

--===============2295668444966135037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 7 Feb 2020, Mat Martineau wrote:

> Userspace should not be able to directly manipulate subflow socket
> options before a connection is established since it is not yet known if
> it will be an MPTCP subflow or a TCP fallback subflow. TCP fallback
> subflows can be more directly controlled by userspace because they are
> regular TCP connections, while MPTCP subflow sockets need to be
> configured for the specific needs of MPTCP. Use the same logic as
> sendmsg/recvmsg to ensure that socket option calls are only passed
> through to known TCP fallback subflows.
>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>
> One other question: is it racy to have __mptcp_tcp_fallback() return an
> unlocked msk, then do the sock_hold(ssk) from an unlocked state? It
> seems like if holding the ssk reference count is necessary at all it
> should be done while the msk is still locked. I'm considering a change
> to __mptcp_tcp_fallback() to have it not release the msk lock and
> instead have all the callers do that.
>
>
> net/mptcp/protocol.c | 52 +++++++++++++++++++++++---------------------
> 1 file changed, 27 insertions(+), 25 deletions(-)


Clarification: This is a patch I'm proposing to send to netdev for the net =

repository, not something to merge to the export branch.


--
Mat Martineau
Intel
--===============2295668444966135037==--
