Content-Type: multipart/mixed; boundary="===============1710382470587609442=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP Upstreaming wiki
Date: Mon, 23 Apr 2018 14:53:55 -0700
Message-ID: <alpine.OSX.2.21.1804231446530.4969@mjmartin-mac01.sea.intel.com>
In-Reply-To: f4ba293a-8cd4-8996-4400-579de2e46532@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 546

--===============1710382470587609442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 23 Apr 2018, Rao Shoaib wrote:

>
>
> On 04/20/2018 05:17 PM, Mat Martineau wrote:
>> =

>> Hello -
>> =

>> I've set up a wiki for our project:
>> =

>> https://github.com/multipath-tcp/mptcp_net-next/wiki
>> =

>> To start with I've added some information that was otherwise buried in o=
ur =

>> mailing list archives. This includes a summary of what the community has =

>> shared so far, meeting information, and pointers to relevant resources.
>>
> Hi Mat,
>
> Why is the following a requirement for the initial implementation
>
> "Move away from meta-sockets, treating each subflow more like a regular T=
CP =

> connection. The overall MPTCP connection is coordinated by an upper layer =

> socket that is distinct from tcp_sock."
>
> This can be done later.

Hi Rao,

The idea is to make the MPTCP changes less invasive to TCP by isolating =

the socket-level changes in separate MPTCP-specific socket code. I think =

"less invasive to TCP" is an important goal from the start.

--
Mat Martineau
Intel OTC

--===============1710382470587609442==--
