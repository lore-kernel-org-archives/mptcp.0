Content-Type: multipart/mixed; boundary="===============1801646616652433925=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH MPTCP 0/5] mptcp: add reset and fastclose option
 support
Date: Thu, 12 Nov 2020 14:55:31 -0800
Message-ID: <44ea321-12f2-3c7d-2621-771db8a36fe8@linux.intel.com>
In-Reply-To: 20201112094817.GK23619@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 6705

--===============1801646616652433925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2020, Florian Westphal wrote:

> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>> I had a couple of minor questions on patch 3, but nothing that would keep
>> this from going in to the export branch for some more testing. Might be
>> easier to coordinate with Paolo's refactor changes to the workqueue that
>> way.
>>
>> Do the selftests get any code coverage on this, for example in the
>> new-subflow-not-allowed case?
>
> How would you do that?  I could add a mib counter and check that in the
> script.  But other than that I do not see how to expose any of this to
> the script/mptcp_connect.

I meant it in a different sense: not that there's a specific self test =

result that looks at a count of MPTCP_RST, but that there is some self =

test (such as denying an additional subflow due to a configured limit) =

that would cause MPTCP_RST to be sent and processed. That way the new code =

is at least running during self test and, if memory leak =

checks/lockdep/etc. were enabled we would at least know some portion of =

the MPTCP_RST code was being exercised and checked during the tests even =

if they aren't explictly part of the results.

I should just answer my own question by capturing the pcaps during the =

self tests, but I haven't had a chance to build & run the changes yet and =

was curious if you had already checked.

If there are MIBs that make sense for real-world use, that's great and =

would make for better tests, but I'm not pushing for that now.

>
>> And thanks for looking at packetdrill tests for this,
>> saw the conversation on IRC.
>
> Yes, I plan to send a pull request for fastclose and reset.
>
> As for further direction, I think next step is to add genl notifications
> so mptcpd can learn about subflows that are added/removed, the reset
> code could then be exposed to userspace in the 'subflow was reset'
> case.
>

Good plan. Thanks.

--
Mat Martineau
Intel
--===============1801646616652433925==--
