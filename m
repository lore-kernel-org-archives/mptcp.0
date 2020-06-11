Content-Type: multipart/mixed; boundary="===============7807143751661843747=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: close poll() races
Date: Thu, 11 Jun 2020 20:51:45 +0200
Message-ID: <02e94e8f-edb4-32dc-1a5b-b0a90d0385e9@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2006101722240.42607@jkolinsk-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4654

--===============7807143751661843747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 11/06/2020 02:52, Mat Martineau wrote:
> =

> On Wed, 10 Jun 2020, Paolo Abeni wrote:
> =

>> mptcp_poll always return POLLOUT for unblocking
>> connect(), ensure that the socket is a suitable
>> state.
>> The MPTCP_DATA_READY bit is never cleared on accept:
>> ensure we don't leave mptcp_accept() with an empty
>> accept queue and such bit set.

Thank you for the patch and the review!

>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---
>> This can be:
>> - keep as is
>> - split in 2 patches (listen fix and connect fix)
>> - squashed into "mptcp: fallback in case of simultaneous connect",
>> - partially squashed (listen fix) and partially keeped as separate patch
>>
>> I'll personally vote for option 1 or 3 but I'm open to other
>> alternatives ;)
> =

> Option 1 sounds good, but I don't object to #3

I picked the option 1 because the "mptcp: fallback in case of =

simultaneous connect" is currently waiting for review :)

So this patch is now at the end of the series.

- 76c6304b26cb..e914fa85bdc4: result

The "export" branch has been updated. Tests are still OK!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7807143751661843747==--
