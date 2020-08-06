Content-Type: multipart/mixed; boundary="===============1497089711031578705=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 00/13] mptcp: multiple xmit substreams support
Date: Thu, 06 Aug 2020 22:17:54 +0200
Message-ID: <882c93ea-94b9-8369-0b9f-487920db7d64@tessares.net>
In-Reply-To: 2297c590-8ee2-af2f-67d8-d41e24ddd187@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5504

--===============1497089711031578705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 06/08/2020 20:39, Matthieu Baerts wrote:
> Hi Paolo, Florian,
> =

> On 05/08/2020 19:56, Paolo Abeni wrote:
>> This covers the feedback from Florian on the RFC series, please see
>> the individual patches changelog for the details.
>>
>> The only exception is: I'm retaining the MPTCP_SEND_SPACE bit, which =

>> looks
>> required as per ML discussion.
>>
>> The MPTCP window code is now more conservative and I do not see out of =

>> window
>> errors.
>>
>> Some self-tests cases are still failing - do not reach the expected =

>> aggregated
>> bwidth - but I've not investigated yet. multiple stream self-tests are =

>> not
>> enabled yet.
>>
>> It would be great if we could starting merging this in the export branch,
>> and improve incrementally.
> =

> Thank you for the patches and the reviews!
> =

> I just added these 13 patches at the end of the export branches.
> =

> Tests are in progress! I will inform you about the status later once it =

> is done.

I added a small fix:

- def1b00509ad: mptcp: fix compilation warning
- no co-dev/signed-off modified

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1497089711031578705==--
