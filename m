Content-Type: multipart/mixed; boundary="===============7098470740078478432=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "selftests: mptcp: launch
 mptcp_connect with timeout"
Date: Mon, 08 Mar 2021 11:55:14 +0100
Message-ID: <72dcb22e-8c23-b896-2c6a-76ac9982bf14@tessares.net>
In-Reply-To: 7049c3e9920228c47a74d2b7d58910c9d5ca57f0.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8073

--===============7098470740078478432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 08/03/2021 11:23, Paolo Abeni wrote:
> On Mon, 2021-03-08 at 11:16 +0100, Matthieu Baerts wrote:
>> In diag.sh, we want to send signals to mptcp_connect instances that have
>> been started in the netns. But we cannot send this signal to 'timeout'
>> otherwise that will stop the timeout and print something like:
>>
>>    # ./diag.sh: line 1: 9536 Done echo a
>>    # 9537 User defined signal 1 | timeout ${timeout_test} ip netns (...)
>>
>> Instead of trying to find the right PID and storing them in an array, we
>> can simply use the output of 'ip netns pids' and send a signal to all
>> these PIDs.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>>      to be squashed in "selftests: mptcp: launch mptcp_connect with time=
out"
> =

> Nice cleanup! LGTM!

Thank you for the quick review!

- 908234a713ef: "squashed" in "selftests: mptcp: launch mptcp_connect =

with timeout"
- 0e661d1c15c6: tg:msg: notice about diag.sh modif
- Results: ec0b131d1b83..917144c5a66a

Tests + export have been started!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7098470740078478432==--
