Received: from mta1.migadu.com (out-204.mta1.migadu.com [95.215.58.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185572DA757
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 05:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685199; cv=none; b=YIV1y2Qz+KUDQeeTDOdXGgONa6cF6FInrgbjQWR9i8OpBjAix2/MGyHOXS9iylvX+anEbidRGXBrKy0gSNUqUexSSQyj9ML+QPCFUCX6eSxxW3TMIObfeyUJgghanwP2VX7F835mkWa3JymOxEuMx9Jc1XJXO6yMuGRf1hn9L2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685199; c=relaxed/simple;
	bh=XbyGUsge3VC3S0RqolVZe3qdZQh29QrZY9bQH2sT1N4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z143UIOJmEghpENSmcfZKUIE+Bgt5/PP6CuIfC9JTdYAuoBRiDrBV+L/+JoHwFMfZKftxhU3ZHF88l1BcggVnFat5IT+US42BK850FxNzwN1K4G4+SzAIfPgsOuTK7Cxn3RBkpGjEYkBt+DkaYTaARZGbK5k0k00dq2h5782ixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kDi6vXoA; arc=none smtp.client-ip=95.215.58.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kDi6vXoA"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=XbyGUsge3VC3S0RqolVZe3qdZQh29QrZY9bQH2sT1N4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786685194; v=1; x=1787289994;
 b=kDi6vXoAYWzOSwliGGMSIu5bRerto740IkutYhLrvUGroKpeClqbG5T+xos3tqnsmtkRfbXm
 9vHRFfUKOhyIIVafI9nf+yUmwkH0NVxW09cSrLXeLpbx7Pjmu51rA3tmQRY4l/nqbE8mDRd7XBI
 Y9DrMXc4xgUNbJ6WgOdDOj40=
X-Envelope-To: mptcp@lists.linux.dev
Received: from [192.168.1.116] (111.162.215.50)
	by smtp.migadu.com with ESMTPS id de36133a81ac2e7a;
	Fri, 14 Aug 2026 05:26:34 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <d446f4a1-f100-453e-a952-5353505a465a@linux.dev>
Date: Fri, 14 Aug 2026 13:26:27 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [RFC PATCH mptcp-next] mptcp: annotate data-races around sysctl
 reads
To: gang.yan@linux.dev, mptcp@lists.linux.dev
References: <20260814032749.2222975-1-cui.tao@linux.dev>
 <44897d3c50a4ce9db11d52c19382a2c9f648a62c@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <44897d3c50a4ce9db11d52c19382a2c9f648a62c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

在 2026/8/14 11:51, gang.yan@linux.dev 写道:
> August 14, 2026 at 11:27 AM, "Tao Cui" <cui.tao@linux.dev mailto:cui.tao@linux.dev?to=%22Tao%20Cui%22%20%3Ccui.tao%40linux.dev%3E > wrote:
> 
> Hi, Tao
> 
> Thanks for your patch, but it has been submitted by Matt before in [1].
> 
> I think Matt wanted change the PM and sched sysctl from string to atomically,
> that may need another patches (READ_ONCE is not enough), right? If no, you can
> wait for the other maintainers' reply.
> 
> If yes, I still think this patch should keep author as matt, the rest of
> others can be yours.
> 
> Note: Some patches about sched is only in our export branch, not mainlined,
> so it's better to do your work based on it.
> 

Thanks for the review. I did see #626 before sending and referenced
it, I just read its scope wrong: I assumed the patch it links was only
about the string sysctls and missed that the numeric readers were
already covered there.

And thanks for the export branch tip, I'd only been looking at
mainline and didn't know some of the sched patches are only in export.

The only bit mine adds is the WRITE_ONCE() on the pm_type store in
proc_path_manager(), to pair with the mptcp_get_pm_type() read. Matt,
if you want that too just grab it, otherwise I can send it as a small
follow-up.

Thanks,
Tao
> [1] https://patchwork.kernel.org/project/mptcp/patch/20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-4-d7c842e80446@kernel.org/
> 
> Thanks
> Gang
> 
>>
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> #626 plans a READ_ONCE-over-sysctls series for the string sysctls; this
>> is the numeric side. Asking whether to send it on its own or fold it in.
>>
>> The per-netns MPTCP sysctl values (net.mptcp.enabled, add_addr_timeout,
>> checksum_enabled, allow_join_initial_addr_port, stale_loss_cnt,
>> close_timeout, pm_type) are written from the sysctl handlers and read
>> without locking through the ctrl.c accessors.
>>
>> Add READ_ONCE() on the readers and WRITE_ONCE() on the pm_type store in
>> proc_path_manager(), matching what is already done for other mptcp
>> fields (fully_established, local_id, remote_id, sysctl_tcp_wmem[0]).
>>
>> The string sysctls (path_manager, scheduler) are not covered: they need
>> atomic replacement, see the tracker below.
>>
>> KCSAN reproduces the race on net.mptcp.enabled, and the READ_ONCE makes
>> it go away:
>>
>>  BUG: KCSAN: data-race in mptcp_is_enabled / proc_dou8vec_minmax
>>
>>  write to 0xffff8f93c18553e9 of 1 bytes by task 214 on cpu 1:
>>  proc_dou8vec_minmax+0x1b1/0x200
>>  proc_sys_call_handler+0x268/0x350
>>  vfs_write+0x423/0x710
>>
>>  read to 0xffff8f93c18553e9 of 1 bytes by task 72 on cpu 0:
>>  mptcp_is_enabled+0x50/0x60
>>  mptcp_init_sock+0x2a/0x1c0
>>  inet_create+0x3f9/0x5a0
>>
>>  value changed: 0x00 -> 0x01
>>
>> No functional change.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/626
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>  net/mptcp/ctrl.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>> index 63c5747f0f63..b0ef6aea4eba 100644
>> --- a/net/mptcp/ctrl.c
>> +++ b/net/mptcp/ctrl.c
>> @@ -50,39 +50,39 @@ static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
>>
>>  int mptcp_is_enabled(const struct net *net)
>>  {
>> - return mptcp_get_pernet(net)->mptcp_enabled;
>> + return READ_ONCE(mptcp_get_pernet(net)->mptcp_enabled);
>>  }
>>
>>  unsigned int mptcp_get_add_addr_timeout(const struct net *net)
>>  {
>> - return mptcp_get_pernet(net)->add_addr_timeout;
>> + return READ_ONCE(mptcp_get_pernet(net)->add_addr_timeout);
>>  }
>>
>>  int mptcp_is_checksum_enabled(const struct net *net)
>>  {
>> - return mptcp_get_pernet(net)->checksum_enabled;
>> + return READ_ONCE(mptcp_get_pernet(net)->checksum_enabled);
>>  }
>>
>>  int mptcp_allow_join_id0(const struct net *net)
>>  {
>> - return mptcp_get_pernet(net)->allow_join_initial_addr_port;
>> + return READ_ONCE(mptcp_get_pernet(net)->allow_join_initial_addr_port);
>>  }
>>
>>  unsigned int mptcp_stale_loss_cnt(const struct net *net)
>>  {
>> - return mptcp_get_pernet(net)->stale_loss_cnt;
>> + return READ_ONCE(mptcp_get_pernet(net)->stale_loss_cnt);
>>  }
>>
>>  unsigned int mptcp_close_timeout(const struct sock *sk)
>>  {
>>  if (sock_flag(sk, SOCK_DEAD))
>>  return TCP_TIMEWAIT_LEN;
>> - return mptcp_get_pernet(sock_net(sk))->close_timeout;
>> + return READ_ONCE(mptcp_get_pernet(sock_net(sk))->close_timeout);
>>  }
>>
>>  int mptcp_get_pm_type(const struct net *net)
>>  {
>> - return mptcp_get_pernet(net)->pm_type;
>> + return READ_ONCE(mptcp_get_pernet(net)->pm_type);
>>  }
>>
>>  const char *mptcp_get_path_manager(const struct net *net)
>> @@ -230,7 +230,7 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
>>  pm_type = MPTCP_PM_TYPE_KERNEL;
>>  else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) == 0)
>>  pm_type = MPTCP_PM_TYPE_USERSPACE;
>> - pernet->pm_type = pm_type;
>> + WRITE_ONCE(pernet->pm_type, pm_type);
>>  }
>>  }
>>
>> --
>> 2.43.0
>>

