Content-Type: multipart/mixed; boundary="===============3013983566630140097=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] Squash-to: "tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions"
Date: Thu, 19 Dec 2019 22:51:00 +0100
Message-ID: <93ac30a8-ff6c-dcb6-da5d-e3250cfeabf8@tessares.net>
In-Reply-To: 9232137cb6206399c8c762064423ac6888dc0620.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3184

--===============3013983566630140097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again,

On 19/12/2019 21:34, Paolo Abeni wrote:
> On Thu, 2019-12-19 at 21:29 +0100, Matthieu Baerts wrote:
>> Hi again,
>>
>> On 19/12/2019 21:26, Matthieu Baerts wrote:
>>
>> [...]
>>
>>> - f21b48165301: "squashed" in "tcp: Prevent coalesce/collapse when skb
>>> has MPTCP extensions"
>>> - 4dc8f2357520: "Signed-off-by" + "Co-developed-by"
>>> - 5f651be5c6db: conflict in t/mptcp-Add-MPTCP-socket-stubs
>>> - bc6adc5c4e02: conflict in t/mptcp-Handle-MPTCP-TCP-options
>>> - 63a1588ffa98: conflict in
>>> t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
>>> - f38f78ba4f29: conflict in t/mptcp-Implement-MPTCP-receive-path
>>> - 59fa1bb6f670..869248dbe005: result
>>
>> And the commit message has been updated:
>>
>> - db1a460c8aa0: tg: we do coalesce/collapse now

- d9494af52c13: tg:msg: fix changelog version

We are in v4 for part 1. Spotted by Mat!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3013983566630140097==--
