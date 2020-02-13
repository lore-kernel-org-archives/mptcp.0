Content-Type: multipart/mixed; boundary="===============2181352434626152422=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/6] Squash-to: "mptcp: Implement path manager
 interface commands"
Date: Thu, 13 Feb 2020 08:56:41 -0800
Message-ID: <alpine.OSX.2.22.394.2002130856010.41270@echiprou-mobl.amr.corp.intel.com>
In-Reply-To: 62d99523b475296ba37280556f42758fee300e60.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3652

--===============2181352434626152422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 13 Feb 2020, Paolo Abeni wrote:

> On Wed, 2020-02-12 at 18:05 -0800, Mat Martineau wrote:
>> +static bool mptcp_pm_work_pending(const struct mptcp_pm_data *pm)
>>> +{
>>> +	return (READ_ONCE(pm->local_addr_used) <
>>> +		READ_ONCE(pm->local_addr_max)) ||
>>> +	       (READ_ONCE(pm->add_addr_signaled) <
>>> +		READ_ONCE(pm->add_addr_signal_max));
>>> +}
>>
>> It looks like these values are only modified under a lock, but are read
>> some of the time without a lock. If the values are concurrently modified
>> is it harmless? It would be helpful to have at least a comment explaining
>> the expected locking semantics.
>>
>> Would it be overkill to pack the values that are compared (like
>> local_addr_used and local_addr_max) so they can be read & written
>> together?
>
> Thank you for the feedback! I'm double minded about this READ_ONCE
> stuff. I'd like to avoid lock osperation when possible but I agree the
> current impl is ugly.
>
> What if I a single 'work_pending' bool in 'struct mptcp_pm_data', let
> pm_netlink WRITE_ONCE it as needed, and use it to replace the above
> code?
>

Sure, that looks like a safe approach.

--
Mat Martineau
Intel
--===============2181352434626152422==--
