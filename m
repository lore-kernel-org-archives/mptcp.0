Content-Type: multipart/mixed; boundary="===============6600433496413722192=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp:init: panic in case of error
Date: Thu, 06 Jun 2019 17:03:44 +0200
Message-ID: <3e982fa0-1e26-5bd6-edc3-f45a387e5f5e@tessares.net>
In-Reply-To: 8e63b0163210cc5a63d7aa04142cce2fbb9c57eb.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1306

--===============6600433496413722192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 05/06/2019 20:14, Peter Krystad wrote:
> =

> Looks good to me Matthieu, thanks for the improvements.

Thank you for your review!

> Peter.
> =

> On Fri, 2019-05-31 at 17:18 +0200, Matthieu Baerts wrote:
>> The idea is to mimic what is done in tcp_init() and not ignore errors
>> from the init phase. It also simplifies the code as we don't have to
>> manage exit parts anymore.
>>
>> Can be squashed in:
>> - "mptcp: Add MPTCP socket stubs" (mptcp_init())
>> - "mptcp: Associate MPTCP context with TCP socket" (subflow_init())
>> - "mptcp: Create SUBFLOW socket for incoming connections" (subflow_ops)

- c99bd3897382: "squashed" in "mptcp: Add MPTCP socket stubs"
- 9e915dbce7e6: conflict
- 7cf2e6c94084 + 5c49d37d3a1a: "squashed" in "mptcp: Associate MPTCP
context with TCP socket"
- 5168793274d7: conflict
- 612ce5b15729: conflict
- a8115b9c533d: conflict
- 239f3baa2dc0: "squashed" in "mptcp: Create SUBFLOW socket for incoming
connections"
- 3016eb29bc0c: conflict
- fe95c134e25a: remove an useless 'return' after having applied this
full patch
- 4c9253e8e57e + 483f621c7151: add missing '\n' in the two new panic()
- 78190143f7fb..227976e0d2de: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6600433496413722192==--
