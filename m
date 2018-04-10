Content-Type: multipart/mixed; boundary="===============6162475266398949641=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 1/9] Modify tcp structures to support function
 pointers
Date: Mon, 09 Apr 2018 22:19:57 -0700
Message-ID: <c11199d8-3859-10f0-89b7-ba861ac5b769@oracle.com>
In-Reply-To: 20180409044101.GW16289@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 529

--===============6162475266398949641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/08/2018 09:41 PM, Christoph Paasch wrote:
> On 30/03/18 - 10:32:23, Rao Shoaib wrote:
>>
>> On 03/27/2018 02:36 AM, Christoph Paasch wrote:
>>> it is important to explain (in the commit-message) for each of these ca=
llbacks
>>> why they are needed for an MPTCP implementation and why it can't be done
>>> without them.
>>>
>>> This is important to allow people to understand why the change is neces=
sary and
>>> where it is leading to. Ignoring potential performance hits for a momen=
t,
>>> callbacks also increase the code-maintenance overhead and thus each of =
them
>>> will need to justified.
>>>
>>>
>>> Christoph
>>>
>>>
>>>
>> These callbacks are needed to make the code more readable and maintainab=
le.
>> These will be replace by the macro anyways so this does not matter.
> Even with the macros, it is important to describe to the reviewer in the
> commit message why each of these changes is there for.
>
>
> Christoph
The patch was not sent to just any group. It was sent to folks who I =

assumed were very familiar with the code and what was being done.=C2=A0 I d=
id =

say.

Following patches modify TCP code to enable implementation of MPTCP. MPTCP =
implementation requires sharing of TCP code with minor modification here an=
d there. In order to keep the TCP code clean and easy to maintain, common c=
ode has been moved to new functions for use by both TCP and MPTCP. struct t=
cp_sock now has function pointers and based on the socket type (TCP/MPTCP) =
appropriate function is called.


Shoaib

>


--===============6162475266398949641==--
