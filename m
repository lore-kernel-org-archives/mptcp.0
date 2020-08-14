Content-Type: multipart/mixed; boundary="===============8937389527547709293=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: sendmsg: reset iter on error
Date: Fri, 14 Aug 2020 12:48:17 -0700
Message-ID: <alpine.OSX.2.23.453.2008141245480.20141@cakenne1-mobl1.amr.corp.intel.com>
In-Reply-To: 20200814135634.12996-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5557

--===============8937389527547709293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Aug 2020, Florian Westphal wrote:

> Once we've copied data from the iterator we need to revert in case we
> end up not sending any data.
>
> This bug doesn't trigger with normal 'poll' based tests, because
> we only feed a small chunk of data to kernel after poll indicated
> POLLOUT.  With blocking IO and large writes this triggers. Receiver
> ends up with less data than it should get.
>
> Fixes: 72511aab95c94d ("mptcp: avoid blocking in tcp_sendpages")
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============8937389527547709293==--
