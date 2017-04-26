Content-Type: multipart/mixed; boundary="===============6038193270379816468=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: Register handlers for extra TCP options
Date: Wed, 26 Apr 2017 13:10:50 -0700
Message-ID: <aea3f14a-bf7c-d8b9-b5d9-49fe8e1ca349@oracle.com>
In-Reply-To: 918883b9-18f0-c29a-0d20-00592cd27631@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 11

--===============6038193270379816468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/26/2017 12:54 PM, Rao Shoaib wrote:
> Hi Matt,
>
> Good work see my comments inline..
>
>
> On 04/24/2017 04:06 PM, Mat Martineau wrote:
>>
>> On Thu, 20 Apr 2017, Mat Martineau wrote:
>>
>>> Allow additional TCP options to be handled by registered hook
>>> functions.
>>>
>>> Option parsing will call the provided 'parse' function when a TCP =

>>> option
>>> number is not recognized by the normal option parsing code.
>>>
>>> The 'prepare' and 'prepare_req' functions determine the required space
>>> for registered options and store associated data. There are two =

>>> variants
>>> because options must be generated for connections that are associated
>>> with either tcp_sock or request_sock structures.
> If I understand correctly the only difference should be the options =

> chosen. Why not handle this as is done today, syn and established =

> options ?
Let me clarify my comment, Why can't we just pass in a flag or the =

options code can just look at the TCP header, that would avoid keeping =

two lists.

Rao


--===============6038193270379816468==--
