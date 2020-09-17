Content-Type: multipart/mixed; boundary="===============0650345474361658069=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: split mptcp_clean_una function
Date: Thu, 17 Sep 2020 15:53:28 -0700
Message-ID: <alpine.OSX.2.23.453.2009171551050.4728@shantika-mobl1.amr.corp.intel.com>
In-Reply-To: 20200910163630.8137-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5921

--===============0650345474361658069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 10 Sep 2020, Florian Westphal wrote:

> mptcp_clean_una() will wake writers in case memory could be reclaimed.
> When called from mptcp_sendmsg the wakeup code isn't needed.
>
> Move the wakeup to a new helper and then use that from the mptcp worker.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 28 +++++++++++++++++-----------
> 1 file changed, 17 insertions(+), 11 deletions(-)
>
> Sending this ahead of the rebase on top of paolos patchset,
> I think this can be integrated stand-alone as it has no dependency
> on sendmsg refactor or poll rework.
>

Looks good to me, thanks Florian. It still applies cleanly to the export =

branch too.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============0650345474361658069==--
