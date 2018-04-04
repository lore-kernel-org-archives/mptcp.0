Content-Type: multipart/mixed; boundary="===============6768659663871329429=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Socket layer changes to MPTCP
Date: Wed, 04 Apr 2018 13:24:39 -0700
Message-ID: <f88cb302-307d-540a-19a6-abd47553954b@oracle.com>
In-Reply-To: alpine.OSX.2.21.1804041148170.44036@chunyuya-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 509

--===============6768659663871329429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/04/2018 11:56 AM, Mat Martineau wrote:
>
> On Wed, 4 Apr 2018, Rao Shoaib wrote:
>
>>
>>
>> On 04/03/2018 06:20 PM, Mat Martineau wrote:
>>>
>>> Hi Rao,
>>>
>>> On Mon, 2 Apr 2018, Rao Shoaib wrote:
>>>
>>>> Hi Mat,
>>>>
>>>> We have an implementation that implements MPTCP with much much less =

>>>> intrusiveness than the current implementation. It's review has not =

>>>> revealed any serious issues. If it's interaction with TCP can be =

>>>> improved further that is great and patches should be submitted.
>>>>
>>>> I have yet to see any other proposal that would result in any =

>>>> better implementation and contrary to individual belief's that some =

>>>> folks have, no one knows what upstream will accept. I bet even =

>>>> David Miller and Eric do not know what they will accept. That is =

>>>> why they asked for an implementation to start a discussion, which =

>>>> we have now.
>>>>
>>>> There is no reason to keep working in the dark. Once we have the =

>>>> discussion there will be ample opportunity to improve the =

>>>> implementation based on some guideline.
>>>
>>> I do see what you're saying about not knowing with total certainty =

>>> what the maintainers will say until they say it, and I also think =

>>> there are benefits to be had from our smaller MPTCP upstreaming =

>>> community in helping each other shape a proposal.
>>>
>>> I think the call on Thursday will be a great opportunity to discuss =

>>> the current proposals and patch sets. The real-time discussions =

>>> there have been very helpful - without the latency of email I think =

>>> we can more quickly understand where there is consensus.
>>>
>> Sorry I can not make it to the call -- I have been asked to attend a =

>> meeting at the same time. I know that this is disruptive to everyone =

>> but it is beyond my control. We can instead meet on Friday or Monday =

>> or wait till the next call.
>>
>> Sorry for the inconvenience.
>
> No problem, given the complexity of group scheduling and time zones I =

> think the April 12th call is the straightforward solution.
>
We can also start the discussion on line and continue on the conference =

call.
My question is why would we not want to ask netdev. I already have asked =

them and they are willing to allow refactoring of TCP code but want to =

look at it first.
My plan is to post a few examples of the refactoring and ask for input. =

I do not have any plans to post the complete patch just yet.

Discussing via email also keeps detailed records.

Shoaib
> -- =

> Mat Martineau
> Intel OTC


--===============6768659663871329429==--
