Content-Type: multipart/mixed; boundary="===============3412292599991499550=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 7/9] mptcp: add netlink based PM
Date: Wed, 26 Feb 2020 10:54:37 +0100
Message-ID: <24deb929-cd4b-e537-6f65-2b4145585e6c@tessares.net>
In-Reply-To: 20200226095134.GO19559@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3808

--===============3412292599991499550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian,

On 26/02/2020 10:51, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
>> On Wed, 2020-02-26 at 10:36 +0100, Florian Westphal wrote:
>>> Paolo Abeni <pabeni(a)redhat.com> wrote:
>>>> I see! Yes, currently we can't limit the number of subflows created for
>>>> a single mptcp socket on a server. I'm unsure how bad that is, as
>>>> usually we allow each client to create an arbitrary high number of TCP
>>>> connection to the server (modulo syn flood).
>>>>
>>>> Still I think adding the ability to impose such limit could be nice. It
>>>> requires an additional hook (from subflow_syn_recv_sock() towards the
>>>> PM). If we agree on that, I can try to cover in a separate
>>>> patch/series.
>>>
>>> I think its a must-have, as file descriptor limits don't apply.
>>
>> Ok I'll work on that!
>>
>> Can we still merge the series without this feature to unblock Peter ?
> =

> No objections, I did not mean that as a veto.

Fine for me too.

I can have a look at that after Florian's rebase.

I will also drop "mptcp: Implement basic path manager" patch as =

mentioned in the cover-letter!

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3412292599991499550==--
