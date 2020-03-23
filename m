Content-Type: multipart/mixed; boundary="===============4124394222864316082=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Additional part 3 squash suggestion
Date: Mon, 23 Mar 2020 18:07:12 +0100
Message-ID: <707528d2-5f45-2ea4-e82e-6272f0df6196@tessares.net>
In-Reply-To: 1e7cca73cbe6e2256f8ab1ee36e4ca879ff13e3c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4047

--===============4124394222864316082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 20/03/2020 02:09, Paolo Abeni wrote:
> On Thu, 2020-03-19 at 16:24 -0700, Mat Martineau wrote:
>> What do you think about also squashing "mptcp: increment MIB counters in=
 a
>> few places" in to the previous MIB commit? Seems like our patch count for
>> part 3 is still kind of high.
> =

> Additionally I think we could submit:
> =

> "mptcp: re-check dsn before reading from subflow"
> "sendmsg: truncate source buffer if mptcp sndbuf size was set from usersp=
ace"
> "subflow: check parent mptcp socket on subflow state change"
> =

> independently from part 3 (either before or later, as it fit better).
> =

> Togethar with the planned squashing, that makes 17 patches for part 3,
> which I hope should be fine.
> =

> WDYT?

As agreed on IRC, I just moved these 3 topic/commits to the end of the =

series:

- fb09a7a55b86: tg: revert =

t/subflow-check-parent-mptcp-socket-on-subflow-state-change
- e8bd34ac0d03: tg: revert =

t/sendmsg-truncate-source-buffer-if-mptcp-sndbuf-size-was-set-from-userspace
- dde8f988d769: tg: now depending on t/mptcp-add-MIB-counter-infrastructure
- a9dba7031fe1: tg: now on top of =

t/selftests-add-test-cases-for-MPTCP-MP_JOIN
- 10ef670b2bbd: Revert "tg: revert =

t/subflow-check-parent-mptcp-socket-on-subflow-state-change"
- a44dbe63118d: Revert "tg: revert =

t/sendmsg-truncate-source-buffer-if-mptcp-sndbuf-size-was-set-from-userspac=
e"
- 2574e7b58fa9: tg: now depending on =

t/sendmsg-truncate-source-buffer-if-mptcp-sndbuf-size-was-set-from-userspace
- ec499ad27205..267d3c188c55: result (empty as expected)

Tests + export is going to be launched soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4124394222864316082==--
