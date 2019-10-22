Content-Type: multipart/mixed; boundary="===============8444266497876512322=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Selftests: 1 error last night 20191022
Date: Tue, 22 Oct 2019 16:42:43 +0200
Message-ID: <0aa5353d-8767-f4a8-11e0-aef5486a628a@tessares.net>
In-Reply-To: e7ff4384826e5fb71b0d69ca4815b4f2a9b1251b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2262

--===============8444266497876512322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 22/10/2019 15:15, Paolo Abeni wrote:
> On Tue, 2019-10-22 at 14:56 +0200, Paolo Abeni wrote:
>> On Tue, 2019-10-22 at 14:14 +0200, Matthieu Baerts wrote:
>>> Hi,
>>>
>>> On 22/10/2019 13:20, Matthieu Baerts wrote:
>>>> Last night I got an error with selftests without KASAN, etc.:
>>>
>>> I also saw the same type of error with a new build.
>>>
>>> Last night, we move net-next from ebcd670d05d5 to 985fd98ab5cc.
>>>
>>> I don't see one specific commit that could cause these new timeout but I
>>> saw a few commits from Eric, mainly to annotate variables for lockless
>>> read, we might have to do the same in MPTCP I guess:
>>
>> Yep we should. But we also should be almost done there ;)
>>
>> Anyhow such change should not responsible of the timeout
>>
>>> - ab4e846a82d0 (tcp: annotate sk->sk_wmem_queued lockless reads)
>>> - e292f05e0df7 (tcp: annotate sk->sk_sndbuf lockless reads)
>>> - ebb3b78db7bf (tcp: annotate sk->sk_rcvbuf lockless reads)
>>> - d9b55bf7b678 (tcp: annotate tp->urg_seq lockless reads)
>>> - e0d694d638db (tcp: annotate tp->snd_nxt lockless reads)
>>> - 0f31746452e6 (tcp: annotate tp->write_seq lockless reads)
>>> - 7db48e983930 (tcp: annotate tp->copied_seq lockless reads)
>>> - dba7d9b8c739 (tcp: annotate tp->rcv_nxt lockless reads)
>>> - eac66402d1c3 (net: annotate sk->sk_rcvlowat lockless reads)
>>> - 8265792bf887 (net: silence KCSAN warnings around sk_add_backlog() cal=
ls)
>>> - 1f142c17d19a (tcp: annotate lockless access to tcp_memory_pressure)
>>> - 60b173ca3d1c (net: add {READ|WRITE}_ONCE() annotations on
>>> ->rskq_accept_head)
>>> - 9669fffc1415 (net: ensure correct skb->tstamp in various fragmenters)
>>
>> This one possibly could, even if it's quite unlikely, I think.
>>
>> Is this failure easily reproducible or it happens once in a lot of
>> runs?
> =

> whoops... it's just occurred to me that untill we merge Florian's
> series "mptcp: sendmsg scheduler skeleton" and specifically the poll()
> related bits (patches 3 and 4) we are subject to a race between
> data_ready() and poll() which can cause a reader to block forever.

Yes but I didn't have this issue before.

> Do I read correctly the log ? is the mptcp self-test script killed by
> some external watchdog? that would match the above scenario.

Indeed, thank you for mentioning that! A new watchdog has been =

introduced, see 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 =

second timeout per test). I guess we will need something like:


diff --git a/tools/testing/selftests/net/mptcp/settings =

b/tools/testing/selftests/net/mptcp/settings
new file mode 100644
index 000000000000..ba4d85f74cd6
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/settings
@@ -0,0 +1 @@
+timeout=3D90


Just trying to find the best value. Doing some quick tests now (with =

KASAN, old machine, etc.)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8444266497876512322==--
