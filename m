Content-Type: multipart/mixed; boundary="===============2571814907684412293=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv3 for netdev: todo list
Date: Tue, 08 Oct 2019 10:06:07 -0700
Message-ID: <alpine.OSX.2.21.1910081002160.27878@thross-mobl.amr.corp.intel.com>
In-Reply-To: 966a0d4f-bd0d-0723-219f-fa31fc4c79cb@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2058

--===============2571814907684412293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2019, Matthieu Baerts wrote:

> Hi Mat,
>
> On 08/10/2019 01:28, Mat Martineau wrote:
>> =

>> On Mon, 7 Oct 2019, Matthieu Baerts wrote:
>> =

>>> - (maybe: Mat, may you already send a new draft for the
>>> cover-letter for this first batch?)
>>> =

>>> I guess for the last one, if Mat, you have the opportunity to start it, =

>>> feel free to already share it.
>>> =

>>> Regarding the cover-letter, here is what we said after the meeting:
>>> =

>>>> In the cover-letter, we would say that we would like to know:
>>>> =C2=A0- if there are any objections on the changes made in the TCP cor=
e.
>>>> =C2=A0- the goal is to send this patch-set as a non RFC one when we are
>>>> =C2=A0=C2=A0 ready with our initial patch-set that we called "part 2".
>>> =

>> =

>> Here's my proposed v3 cover letter.
>
> Thank you for the new draft!
>
>> Did I correctly understand the end of the quoted message above regarding=
 a =

>> non-RFC posting when part 2 is ready?
>
> Yes, I think you do, the message is perfect for me!
>
> I just have two questions below:
>
>> """
>> Subject: [RFC PATCH v3 00/xx] Multipath TCP prerequisites
>> =

>> =

>> The MPTCP upstreaming community has prepared a net-next RFCv3 patch
>> set for review. The scope of this patch set is limited to prerequisite
>> TCP core changes so we can get focused feedback in these areas.
>> =

>> In this patch set we introduce some MPTCP definitions, additional ULP
>> and skb extension features, TCP option space checking, and a few
>> exported symbols.
>> =

>> =

>> Our intent is to send this as a non-RFC series when the next phase of
>> changes are ready to post. That second patch set will add CONFIG_MPTCP
>> in Kconfig, introduce the MPTCP socket type, implement the protocol,
>
> (maybe: implement an initial set of the protocol? Or setup the base?)
>

I could change "implement the protocol" to "implement the basic features =

of the protocol".


>> and add self tests.
>> =

>> =

>> Clone/fetch:
>> https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-rfcv3)
>
> A detail but where should we do the tag? At the end of the patches we are =

> going to send or at the end of the series? (or both)

I vote for "both" - and within the cover letter, it's the tag matching the =

email series that is important to link to.


--
Mat Martineau
Intel

--===============2571814907684412293==--
