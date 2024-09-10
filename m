Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A8036AE0
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725931655; cv=none; b=jMd4yV7Bf/DLbmacDfBb7BgYuQKTiXd48aqasoAHwrG2BkhSxCUq2l2PVnbO+18Yp09hCkr7nv4SNVu6/e8zOZFKwv3f8TEiTxxivOW1SJktBcwykw0Iveip/omQxCxgGBkVMvb9nVqFWywsR+V/rzAwaNkEY8Ox9/UR/600SiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725931655; c=relaxed/simple;
	bh=2UbYoU6jRnrNG2rQ07Rq8sLcIwjV5UQjiqlwSq9CkG0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQev2lnOvm0Ocu/mnYtpmD+NSz7pGDt9hTulz8k55vtrRWBAQDfz1leTRTGJYo/emSPq5lvOfFeQ67f1Ii+uLYJOygK8LQjcOsBh7pm5uuFhuE06yYynZIpTuPoam0VxOfTTWlHMre0yNRlsxctLYQe+bV+duDQbruL9SjayjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=r3vcUAG7; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="r3vcUAG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1725931644;
	bh=c8f6xhpbtuyMwQgr2IdofdOo9jRp587/HZKhfdBx/VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=r3vcUAG7969DuvxLfRka0LDb8MrKiwXgwFw6GnEorsFezsJ/at5JQ2xGi67NG5E8c
	 m/+CcAPPcAIYJTu69UAjbrsraHukhzp3mPzLq6+mYqqJtHcgO0kx22XJbuphFWaQiE
	 vQBEhNlCKJu2xHQD9hEDy9z+VLvQjkwOh5UNbTKU=
Received: from localhost ([39.156.73.13])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 686A1E4E; Tue, 10 Sep 2024 09:26:06 +0800
X-QQ-mid: xmsmtpt1725931566t703u4qc7
Message-ID: <tencent_D1213243EC4704D175815109CA4A18FD2708@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb56WOqoZqAzm2rkXCV9RWULzPdzfyj+K/PzFA1sach41/oPM85+9
	 R+7hnLNMjKlk0l+8v/hNIljoI8VO7Z/2atGv4N7GbQVDgDuKezuTNqI86UaUhVEJRqLCpr4c24tc
	 j5xIgr2GfylksmwHOu9m5BkKN/9IFOXcbeKCsPctv1wlGHKuYDEqpnimBn507lkAjEbgWlcLSQYh
	 mYl+30zLuO0VvBWVIY4WHwG9shZOMbneSf/HZKGs21e6MF3oBMojEXY+dP2v7dpQWom1MTqqHRbd
	 Nq7TSKitqnw7h6i/KEb5yu9s40hIyME9u7N/Mv+kQXrXMCKTAJwr9wi1q/osJHR0Q51Orwi+q3Sn
	 uwEMpPyVkv5Ccou6YMpIBz23sUkcihEJW9LE+w8dHWzHVl8VApCKxT21cEQ/7kOjzBXnUgaPvtuo
	 kw9cSJtAf6tIgVXxbZTUx0OjYb3v/8danDGWeb9UF+FM69pNVltWfnDziNuBHrT2cigZGDy2V/dK
	 RYsZ4BDQpzgqFPEfsN2BHUheOD1+lFBPlda1sKPSO16AJr5j9YsfaM9qJ6Y6uSyg7Q2XdVOzx7lW
	 ItmxLWyxlcBoGFQB1cu0xPnQRpkGGpIyxGh4CwOwHdg+2SOOWvsf0Ln54EUnT7uohpVAnvCfKhtv
	 FB1KJwOgdx03I6op6ahCbFjcZb58z2ESt9rmQTxrZTbv7NXS8fivl3OT1mXRhj93ClZ9k/5/j7rC
	 vKu+33n0/fhXCEsAJwxsZ5mLizYH2OmgrMdxpq+8bXQqgOVONU1mbZR8isVRd1lKx501SREr4Y/5
	 02srlkkD7fifbI88JDinn5LyNbXenqwaA/LDOj0RQx48uLEPin7BBJueJiMitEqL3XJwL1DFDQAD
	 NbZip+huLwvKUpjCYsrKDYJUqI/67hTwB1IsCrXSuZ4ly9J3nUbPlvpGJ+R+k790fUySR+CJSNd0
	 T6fxvPOFGOGJowCh0Nk3L6Z2eu769X7L9kn5F53kXTRUaKFswVYasSTBXjt2+yoc+6OJtC0r+z3t
	 aIEAI7Cl7xy7F6aK4YfiQVTPKEwH4=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
Date: Tue, 10 Sep 2024 09:26:06 +0800
From: Gang Yan <gang_yan@foxmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp <mptcp@lists.linux.dev>
Subject: Re: [mptcp-next] mptcp: Add data race when accessing the
 fully_established of subflow
X-OQ-MSGID: <Zt-gLmM7bCpS3MoN@yangang-TM1701>
References: <tencent_604F30643CD92D084CEB0AA3BE951B30C009@qq.com>
 <d9f3f461-b1dd-4410-977e-2dc34d0d485a@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9f3f461-b1dd-4410-977e-2dc34d0d485a@kernel.org>

Hi Matt,

On Mon, Sep 09, 2024 at 05:39:45PM +0200, Matthieu Baerts wrote:
> Hi Gang Yan,
> 
> On 09/09/2024 03:14, gang_yan@foxmail.com wrote:
> > From: YANGANG <yangang@kylinos.cn>
> > 
> > We introduce the same handling for potential data races with the
> > 'fully_established' flag in subflow as previously done for
> > msk->fully_established.
> Thank you for this patch!
> 
> Now in our tree (feat. for net-next) with the suggested modifications
> from my previous review, but also a different subject, I hope that's OK:

Thanks for applying this patch for me. I have an extra request. Please update
my email address as 'Gang Yan <yangang@kylinos.cn>', both after 'From:' and 
'Signed-off-by:'. 

Best wishes!
Gang Yan
> 
> New patches for t/upstream:
> - 633d4f19df42: mptcp: annotate data-races around subflow->fully_established
> - Results: 2272658b40f1..42ffd3cd6ef4 (export)
> 
> Tests are now in progress:
> 
> - export:
> https://github.com/multipath-tcp/mptcp_net-next/commit/f1203796582877704db22e3519e514d0864a131b/checks
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
> 

