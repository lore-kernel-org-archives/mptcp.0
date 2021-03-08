Content-Type: multipart/mixed; boundary="===============0098569185054243104=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 2/3] mptcp: only admit explicitly
 supported sockopt
Date: Mon, 08 Mar 2021 12:30:34 +0100
Message-ID: <f9e168f5-5ceb-fe66-9a26-6765c3f6f696@tessares.net>
In-Reply-To: e046688633b4689572e35754cbacbb8ac92e3894.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8074

--===============0098569185054243104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 08/03/2021 10:07, Paolo Abeni wrote:
> On Sat, 2021-03-06 at 08:30 +0100, Matthieu Baerts wrote:
>> On 06/03/2021 00:39, Mat Martineau wrote:
>>>
>>> ...it would be a lot more clear that the mentioned options are attached
>>> to the "return false;", and the case labels are for the "return true".
>>>
>>> (this applies to the other SOL levels too)
>>
>> Should we eventually add notes somewhere -- socket.h, in.h, in6.h, tcp.h
>> -- to ask other devs to eventually contact us when new sockopt are being
>> added?
>> Not sure it is something common to do but it can be useful for us and
>> these devs.
> =

> Replying to this point here, as it will be the only comment I plan to
> not include in the next iteration: I think this is on us for the time
> being. I would avoid core networking changes.

I understand if we cannot do that.

> Additionally, if a new socket option is added, the whitelist model will
> fit gracefully, as the new socket option will be unimplemented for
> MPTCP and user-space will get back a resonable error code.

That's fine then. We might allow one option with a delay because I guess =

we are not going to monitor all changes with these sockopt but I guess =

that's fine. At least an error code will be provided.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0098569185054243104==--
