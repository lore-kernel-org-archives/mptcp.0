Content-Type: multipart/mixed; boundary="===============7521989809796581558=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] move TCP-related commits to the beginning
Date: Tue, 08 Oct 2019 13:41:36 +0200
Message-ID: <dbbfa10b-975c-26f5-dca2-8abc36a6c5ef@tessares.net>
In-Reply-To: 5b077f34-3255-0b9e-4d6f-7793ffb8e483@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2044

--===============7521989809796581558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 08/10/2019 11:08, Matthieu Baerts wrote:
> Hi Mat,
> =

> On 08/10/2019 00:54, Mat Martineau wrote:
>>
>> Matthieu,
>>
>> On Mon, 7 Oct 2019, Matthieu Baerts wrote:
>>
>>> On 07/10/2019 17:23, Florian Westphal wrote:
>>>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>>>> On 07/10/2019 17:00, Florian Westphal wrote:
>>>>>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>>>>>>> ... this turns 'tcp: clean ext on tx recycle' into a one-line =

>>>>>>>> change.
>>>>>>>
>>>>>>> Good idea! Just applied this diff and added your signed-off to =

>>>>>>> the patch.
>>>>>>
>>>>>> Thanks!
>>>>>
>>>>> Just in case you want to check, here is the diff between my two =

>>>>> branches:
>>>>
>>>> [..]
>>>>
>>>>> If there is no objection, I am going to re-create the TopGit tree =

>>>>> with this
>>>>> new branch then!
>>>>
>>>> Looks good, go ahead.
>>>
>>> TopGit tree re-created, export branch has been recreated, tests are =

>>> still OK.
>>>
>>
>>
>> I have one more change to suggest. In "tcp: Expose tcp struct and =

>> routine for MPTCP", we don't need to expose tcp_v4_init_sock() - that =

>> was probably associated with the pre-ULP code.
> =

> Good catch!
> =

>> That reduces the patch to only exporting tcp_request_sock_ipv4_ops, =

>> which I would suggest squashing with "tcp: Export low-level TCP =

>> functions"

I already started the modifications, for the moment, only the squash. I =

didn't move the commit nor exported tcp_request_sock_ipv6_ops.

- 73abc7855679: modify the commit message (I have to do that in two =

different commits for TG, not sure why)
- d20e51f3bbc3: partly squash 'tcp: Expose tcp struct and routine for =

MPTCP' into 'tcp: Export TCP functions and ops struct'
- 32fd0f33f52f: revert topic t/tcp-Expose-tcp-struct-and-routine-for-MPTCP
- 67ec4e697687: remove empty topic =

t/tcp-Expose-tcp-struct-and-routine-for-MPTCP
- 0e4e909653ea..846470882b58: result

Tests are still OK!

Feel free to tell me I have to do any other modifications (e.g. expose =

tcp_request_sock_ipv6_ops).

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7521989809796581558==--
