Content-Type: multipart/mixed; boundary="===============4831884328944037331=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: split mptcp_clean_una function
Date: Fri, 18 Sep 2020 17:37:55 +0200
Message-ID: <0442ff74-09e7-05f9-0ead-26a0a5da6d2f@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2009171551050.4728@shantika-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5935

--===============4831884328944037331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 18/09/2020 00:53, Mat Martineau wrote:
> =

> On Thu, 10 Sep 2020, Florian Westphal wrote:
> =

>> mptcp_clean_una() will wake writers in case memory could be reclaimed.
>> When called from mptcp_sendmsg the wakeup code isn't needed.
>>
>> Move the wakeup to a new helper and then use that from the mptcp worker.
>>
>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>> ---
>> net/mptcp/protocol.c | 28 +++++++++++++++++-----------
>> 1 file changed, 17 insertions(+), 11 deletions(-)
>>
>> Sending this ahead of the rebase on top of paolos patchset,
>> I think this can be integrated stand-alone as it has no dependency
>> on sendmsg refactor or poll rework.
>>
> =

> Looks good to me, thanks Florian. It still applies cleanly to the export =

> branch too.
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thank you for the patch and the review!

- 0032722d977f: mptcp: split mptcp_clean_una function
- a0e1e786f7d2..dcdf6c22dc6f: result

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4831884328944037331==--
