Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CF204C26
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166547; cv=none; b=eWfLt5Ff8f/MSewazEEVhVNNt8P5L93JPkw8riWEBfsyX5GJ7mfubQqDYTlbpBGlbyf9miF8myBZiMlzgj1hLlff2adp8TsXrc984QuxoSUQBgtP/uqsxTdBkcB8Unmv3tAdu+3C7A8iJ96n4jAFUR3OZnvHjRmFTRciyltTOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166547; c=relaxed/simple;
	bh=O2r2L7KdrFbCthfndJPTN7bYUmzfX31AqZSx4wass+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y53m4de/yDAk7H9En5y5cvbEKhMeS2gfuTXStTjjEUOKOELoPHeEWBdwcFJ10hbegV/rJUKvfrknc5CoVVnKV2BVcOEUqhBGTJa7yoVwWvoRsm382wE77NCHyopnSOsxpBt8c3ELYR3uDxMrgd7Z0xF78dVxNxh+m2SM33rF2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG6/nV3d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG6/nV3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E96C4CEE8;
	Wed,  5 Mar 2025 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741166546;
	bh=O2r2L7KdrFbCthfndJPTN7bYUmzfX31AqZSx4wass+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RG6/nV3db5jPBoEDNeb5CUnniAEL9hOI+UCNKqUcxC/N3XaITJuiu9RJIToHA1BIs
	 3giqppzvZ4wFxc+rX+O6OtjLOOJFOLSpOBbdECubGFA1DuMBGOLVBOcw5IYXJQvDsm
	 1ZqWaNQnMGe5mnh0vo0Y/5oARvA5sl/To1pKvU2GWw3kZc0xQtVWJX6uCNfjmR2BzB
	 fIYuofWJQ6cxT8nAyYzBlzmg4nfDZX+qBV/wb5XnryYclYkSnlyFRpBi7h9GSEbSz8
	 CON1D7DghHcmPbduaMvuiQj7s2fIKbiNzAhi35hXZazXyMHEeawBAHbjR2KeX/vP4V
	 +lHx1aCzaV22w==
Message-ID: <8cc21a9a-b5fc-4fa0-a97d-d5e0ca65b732@kernel.org>
Date: Wed, 5 Mar 2025 10:22:23 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v8 06/12] mptcp: pm: in-kernel: register
 mptcp_pm_kernel
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
 <818c00e2242d2f76604c6d70176ab6fa94d7eaa5.1741088339.git.tanggeliang@kylinos.cn>
 <e4ed726a27e8b7564ca33833dcbe735fc158f157.camel@kernel.org>
 <08136d71-ae40-4044-a9de-6b00e78af258@kernel.org>
 <3952f0ebd55c5aed3618ad5933100e18458599d5.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3952f0ebd55c5aed3618ad5933100e18458599d5.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 05/03/2025 10:14, Geliang Tang wrote:
> On Wed, 2025-03-05 at 10:11 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 05/03/2025 02:35, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> On Tue, 2025-03-04 at 19:40 +0800, Geliang Tang wrote:
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> This patch defines the original in-kernel netlink path manager as
>>>> a
>>>> new struct mptcp_pm_ops named "mptcp_pm_kernel", and register it
>>>> in
>>>> mptcp_pm_kernel_register().
>>>>
>>>> This mptcp_pm_ops will be skipped in mptcp_pm_unregister().
>>>>
>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>>> ---
>>>>  net/mptcp/pm.c        |  4 ++++
>>>>  net/mptcp/pm_kernel.c | 26 ++++++++++++++++++++++++++
>>>>  net/mptcp/protocol.h  |  3 +++
>>>>  3 files changed, 33 insertions(+)
>>>>
>>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>>> index a2b210873b23..28ea8bdaa8b0 100644
>>>> --- a/net/mptcp/pm.c
>>>> +++ b/net/mptcp/pm.c
>>>> @@ -1076,6 +1076,10 @@ int mptcp_pm_register(struct mptcp_pm_ops
>>>> *pm)
>>>>  
>>>>  void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
>>>>  {
>>>> +	/* skip unregistering the default path manager */
>>>> +	if (pm == &mptcp_pm_kernel)
>>>> +		return;
>>>> +
>>>>  	spin_lock(&mptcp_pm_list_lock);
>>>>  	list_del_rcu(&pm->list);
>>>>  	spin_unlock(&mptcp_pm_list_lock);
>>>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>>>> index 806a9b5b3c07..e6a1aef738a8 100644
>>>> --- a/net/mptcp/pm_kernel.c
>>>> +++ b/net/mptcp/pm_kernel.c
>>>> @@ -1398,8 +1398,34 @@ static struct pernet_operations
>>>> mptcp_pm_pernet_ops = {
>>>>  	.size = sizeof(struct pm_nl_pernet),
>>>>  };
>>>>  
>>>> +static void mptcp_pm_nl_initialize(struct mptcp_sock *msk)
>>>> +{
>>>> +	bool subflows_allowed =
>>>> !!mptcp_pm_get_subflows_max(msk);
>>>> +	struct mptcp_pm_data *pm = &msk->pm;
>>>> +
>>>> +	/* pm->work_pending must be only be set to 'true' when
>>>> +	 * pm is the default path manager
>>>> +	 */
>>>> +	WRITE_ONCE(pm->work_pending,
>>>> +		   (!!mptcp_pm_get_local_addr_max(msk) &&
>>>> +		    subflows_allowed) ||
>>>> +		   !!mptcp_pm_get_add_addr_signal_max(msk));
>>>> +	WRITE_ONCE(pm->accept_addr,
>>>> +		   !!mptcp_pm_get_add_addr_accept_max(msk) &&
>>>> +		   subflows_allowed);
>>>> +	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
>>>> +}
>>>> +
>>>> +struct mptcp_pm_ops mptcp_pm_kernel = {
>>>> +	.init			= mptcp_pm_nl_initialize,
>>>
>>> A better name would be mptcp_pm_nl_init, but this is already used
>>> in
>>> pm_netlink.c. I would like to rename mptcp_pm_nl_init in
>>> pm_netlink.c
>>> to mptcp_pm_genl_init, do you think this is a good idea?
>>>
>>> If so, is it better to squash this renaming into "mptcp: pm: split
>>> netlink and in-kernel init" or make it a separate patch?
>>
>> What about calling the one here mptcp_pm_kernel_init()?
> 
> mptcp_pm_kernel_init is not good, because other functions start with
> mptcp_pm_nl_:
> 
> struct mptcp_pm_ops mptcp_pm_kernel = {
>         .get_local_id           = mptcp_pm_nl_get_local_id,
>         .get_priority           = mptcp_pm_nl_is_backup,
>         .established            = mptcp_pm_nl_fully_established,
>         .subflow_established    = mptcp_pm_nl_subflow_established,
>         .add_addr_echo          = mptcp_pm_nl_add_addr_echo,
>         .add_addr_received      = mptcp_pm_nl_add_addr_received,
>         .rm_addr_received       = mptcp_pm_nl_rm_addr_received,
>         .rm_subflow_received    = mptcp_pm_nl_rm_subflow_received,
>         .add_addr               = mptcp_pm_nl_add_addr,
>         .del_addr               = mptcp_pm_nl_del_addr,
>         .flush_addrs            = mptcp_pm_nl_flush_addrs,
>         .set_priority           = mptcp_pm_nl_set_priority,
>         .init                   = mptcp_pm_nl_init,
>         .name                   = "kernel",
>         .owner                  = THIS_MODULE,
> };

What about switching to the "mptcp_pm_kernel_" prefix when switching to
the new ops? For some of them, I guess there will be modifications
around the declaration of the function because 'static' will be added, no?

The "mptcp_pm_nl_" was making sense before because everything was in
pm_netlink.c. But now with the split, it might be good to take this
opportunity to rename the functions here to clearly mention it is from
the kernel PM, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

