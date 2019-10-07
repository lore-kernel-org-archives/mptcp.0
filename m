Content-Type: multipart/mixed; boundary="===============7968872426887749052=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv3 for netdev: todo list
Date: Mon, 07 Oct 2019 16:28:55 -0700
Message-ID: <alpine.OSX.2.21.1910071615260.18088@mjmartin-mac01.local>
In-Reply-To: aa523928-008c-b642-b094-e0be545ac45b@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2041

--===============7968872426887749052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 7 Oct 2019, Matthieu Baerts wrote:

> - (maybe: Mat, may you already send a new draft for the
> cover-letter for this first batch?)
>
> I guess for the last one, if Mat, you have the opportunity to start it, f=
eel =

> free to already share it.
>
> Regarding the cover-letter, here is what we said after the meeting:
>
>> In the cover-letter, we would say that we would like to know:
>>  - if there are any objections on the changes made in the TCP core.
>>  - the goal is to send this patch-set as a non RFC one when we are
>>    ready with our initial patch-set that we called "part 2".
>

Here's my proposed v3 cover letter.

Did I correctly understand the end of the quoted message above regarding a =

non-RFC posting when part 2 is ready?


"""
Subject: [RFC PATCH v3 00/xx] Multipath TCP prerequisites


The MPTCP upstreaming community has prepared a net-next RFCv3 patch
set for review. The scope of this patch set is limited to prerequisite
TCP core changes so we can get focused feedback in these areas.

In this patch set we introduce some MPTCP definitions, additional ULP
and skb extension features, TCP option space checking, and a few
exported symbols.


Our intent is to send this as a non-RFC series when the next phase of
changes are ready to post. That second patch set will add CONFIG_MPTCP
in Kconfig, introduce the MPTCP socket type, implement the protocol,
and add self tests.


Clone/fetch:
https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-rfcv3)

Browse:
https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-rfcv3


Thank you for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream
"""


--
Mat Martineau
Intel
--===============7968872426887749052==--
