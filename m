Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CC3205
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 18:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655749627; x=1687285627;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y09SXzmbjWVKvYHrG2CRZ2QvcvUKgaeksaWaV+7kXD4=;
  b=HWZ28AVZfDhB54VxeM3QPiqEnFmqWkCvn7UQ31xJ0vlmMSELIbH3XST4
   9oGx/b0z6R63h7Dp0Y9w/ACZwdkDNTvcPt8qmOXcF+NptJYQ9lojxApE1
   ffPpWRcJL7aFGJNQtVhrek4TrL1+YboSBbpA2z7fl6lilksSWX1vLGnHi
   E2B0Mf4CQtX6TkJRgfjDZSFG2bSpuKVuH64Ay0nvbw5jjqlB/4WAT9NBv
   UdWM0zLYSBCvmRSJ4xMXdSO+hSnFf7/n8WJVzS86QhgAhk211iUDmoh2Y
   gx4zUirQYkqib6OWjSm+vKgPbb8G4KiFz/q4gIGm4CThn0OT0CYu5MmJg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="268674484"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="268674484"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 11:27:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="614474278"
Received: from mmachax-mobl.amr.corp.intel.com ([10.212.156.191])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 11:27:07 -0700
Date: Mon, 20 Jun 2022 11:27:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 3/5] selftests: mptcp: userspace pm subflow
 tests
In-Reply-To: <a2116590-580e-9b95-3224-48cbad6786cf@tessares.net>
Message-ID: <8da3168-a814-c8e6-6f9e-dbaa8975ac9@linux.intel.com>
References: <cover.1655355422.git.geliang.tang@suse.com> <3fe28e031020b282b23e906b1095f1cce16af111.1655355422.git.geliang.tang@suse.com> <655c24a-a36-d7af-5b1d-925191d17c43@linux.intel.com> <a2116590-580e-9b95-3224-48cbad6786cf@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-910435017-1655749627=:5355"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-910435017-1655749627=:5355
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Jun 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> On 18/06/2022 00:10, Mat Martineau wrote:
>> On Thu, 16 Jun 2022, Geliang Tang wrote:
>>
>>> This patch adds userspace pm subflow tests support for mptcp_join.sh
>>> script. Add userpace pm create subflow and destroy test cases in
>>> userspace_tests().
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>> .../testing/selftests/net/mptcp/mptcp_join.sh | 40 ++++++++++++++++++-
>>> 1 file changed, 38 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> index 977c59c540b2..bec22fa38415 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> @@ -657,6 +657,8 @@ do_transfer()
>>>     local userspace_pm=0
>>>     local evts_ns1
>>>     local evts_ns1_pid
>>> +    local evts_ns2
>>> +    local evts_ns2_pid
>>>
>>>     :> "$cout"
>>>     :> "$sout"
>>> @@ -702,13 +704,20 @@ do_transfer()
>>>         # disconnect
>>>         extra_args="$extra_args -I ${addr_nr_ns2:10}"
>>>         addr_nr_ns2=0
>>> +    elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
>>> +        userspace_pm=1
>>> +        addr_nr_ns2=${addr_nr_ns2:10}
>>>     fi
>>>
>>>     if [ $userspace_pm -eq 1 ]; then
>>>         evts_ns1=$(mktemp)
>>> +        evts_ns2=$(mktemp)
>>>         :> "$evts_ns1"
>>> +        :> "$evts_ns2"
>>>         ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1"
>>> 2>&1 &
>>>         evts_ns1_pid=$!
>>> +        ip netns exec ${connector_ns} ./pm_nl_ctl events >>
>>> "$evts_ns2" 2>&1 &
>>> +        evts_ns2_pid=$!
>>>     fi
>>>
>>>     local local_addr
>>> @@ -830,6 +839,8 @@ do_transfer()
>>>     if [ $addr_nr_ns2 -gt 0 ]; then
>>>         local add_nr_ns2=${addr_nr_ns2}
>>>         local counter=3
>>> +        local id=20
>>> +        local tk da dp sp
>>>         while [ $add_nr_ns2 -gt 0 ]; do
>>>             local addr
>>>             if is_v6 "${connect_addr}"; then
>>> @@ -837,9 +848,23 @@ do_transfer()
>>>             else
>>>                 addr="10.0.$counter.2"
>>>             fi
>>> -            pm_nl_add_endpoint $ns2 $addr flags $flags
>>> +            if [ $userspace_pm -eq 0 ]; then
>>> +                pm_nl_add_endpoint $ns2 $addr flags $flags
>>> +            else
>>> +                tk=$(sed -n
>>> 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
>>> +                da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q'
>>> "$evts_ns2")
>>> +                dp=$(sed -n
>>> 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
>>> +                ip netns exec ${connector_ns} ./pm_nl_ctl csf lip
>>> $addr lid $id \
>>> +                                    rip $da rport $dp token $tk
>>> +                sleep 1
>>> +                sp=$(grep "type:10" "$evts_ns2" |
>>> +                     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
>>> +                ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip
>>> $addr lport $sp \
>>> +                                    rip $da rport $dp token $tk
>>> +            fi
>>>             counter=$((counter + 1))
>>>             add_nr_ns2=$((add_nr_ns2 - 1))
>>> +            id=$((id + 1))
>>>         done
>>>     elif [ $addr_nr_ns2 -lt 0 ]; then
>>>         local rm_nr_ns2=$((-addr_nr_ns2))
>>> @@ -919,7 +944,9 @@ do_transfer()
>>>     if [ $userspace_pm -eq 1 ]; then
>>>         kill $evts_ns1_pid
>>>         wait $evts_ns1_pid 2>/dev/null
>>> -        rm -rf $evts_ns1
>>> +        kill $evts_ns2_pid
>>> +        wait $evts_ns2_pid 2>/dev/null
>>
>> Would be nice to use the kill_wait function from "selftests: mptcp: avoid
>> Terminated messages in userspace_pm" here. Can you send a squash-to for
>> that "avoid Terminated messages..." commit that uses kill_wait?
>
> It might be fine not to have this function as the only "kill + wait" we
> have are here: just these two. It might then not be needed to create
> this "kill_wait" helper in mptcp_join.sh.
>
> But up to you :)
>

Yeah, good point. Probably not worth creating the additional function in 
mptcp_join.sh

So: Geliang, you don't need to modify the "avoid Terminated messages..." 
commit.

--
Mat Martineau
Intel
--0-910435017-1655749627=:5355--
