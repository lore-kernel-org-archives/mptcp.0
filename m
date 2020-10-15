Content-Type: multipart/mixed; boundary="===============9020112624314391944=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] selftests: mptcp: add link failure
 test case
Date: Wed, 14 Oct 2020 17:09:00 -0700
Message-ID: <d44679b6-8aa0-a1f9-19b9-4713495de53@linux.intel.com>
In-Reply-To: 20201009151117.6672-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6308

--===============9020112624314391944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Oct 2020, Florian Westphal wrote:

> Add a test case where a link fails with multiple subflows.
> The expectation is that MPTCP will transmit any data that
> could not be delivered via the failed link on another subflow.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> v2: rebase and add 'link loss' to test-case comment.
>     make sure we exit with 1 if file was corrupt or server/client
>     exited nonzero.
>
> .../testing/selftests/net/mptcp/mptcp_join.sh | 135 +++++++++++++-----
> 1 file changed, 97 insertions(+), 38 deletions(-)
>

Thanks for the v2, looks good for the export branch.

--
Mat Martineau
Intel
--===============9020112624314391944==--
