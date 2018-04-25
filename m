Content-Type: multipart/mixed; boundary="===============0208000744838256966=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP Upstreaming wiki
Date: Wed, 25 Apr 2018 09:20:16 -0700
Message-ID: <c09f47fc-3ef1-65ae-04fd-86a96cc6d32f@oracle.com>
In-Reply-To: alpine.OSX.2.21.1804231446530.4969@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 551

--===============0208000744838256966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/23/2018 02:53 PM, Mat Martineau wrote:
>
> On Mon, 23 Apr 2018, Rao Shoaib wrote:
>
>>
>>
>> On 04/20/2018 05:17 PM, Mat Martineau wrote:
>>>
>>> Hello -
>>>
>>> I've set up a wiki for our project:
>>>
>>> https://github.com/multipath-tcp/mptcp_net-next/wiki
>>>
>>> To start with I've added some information that was otherwise buried =

>>> in our mailing list archives. This includes a summary of what the =

>>> community has shared so far, meeting information, and pointers to =

>>> relevant resources.
>>>
>> Hi Mat,
>>
>> Why is the following a requirement for the initial implementation
>>
>> "Move away from meta-sockets, treating each subflow more like a =

>> regular TCP connection. The overall MPTCP connection is coordinated =

>> by an upper layer socket that is distinct from tcp_sock."
>>
>> This can be done later.
>
> Hi Rao,
>
> The idea is to make the MPTCP changes less invasive to TCP by =

> isolating the socket-level changes in separate MPTCP-specific socket =

> code. I think "less invasive to TCP" is an important goal from the start.

Really, IMHO meta socket is not the cause of MPTCP being intrusive. We =

can discuss this requirement later, perhaps an example will help.

Shoaib

>
> -- =

> Mat Martineau
> Intel OTC


--===============0208000744838256966==--
