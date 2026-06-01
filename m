Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8941C72;
	Mon,  1 Jun 2026 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780280551; cv=none; b=cyAs5SssQ1EAXj+QJkNy0o1wMuxjEjOmyIHHNdcObQoNJN7K093izzfQXJBpN71kI51zmLsQW9/vldPwAe4tKh2D/aenNa5CzyQUv/UEk0vSUU0E2mb6TeGor1yvhSV8LqA/FN9KgvVzp7WmFFhLdJzwfMAsnX0BDaOQdTAEaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780280551; c=relaxed/simple;
	bh=CSTIk+EYfgOQEmivd+6MNb6DKAwx2ykz1VGJCY1R/Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjFhTiMztZx1HmrTrJYLN2Xlkv80GBSuA3NJZWbefKvL/SN7AXpGjEcFsBDciO7kddywWfuuPQDiqGQ1uBA1qEb/WJa2QQ6ZMyti2hpSi3sjwnY4oDyqkBiZGTSTXqnISN0pxd0n9hr9WB6NjoCHIBfxoV4qXQJA1vGry2pJcUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2KPmZi5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2KPmZi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8111F00893;
	Mon,  1 Jun 2026 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780280550;
	bh=UeqB1s/dR7PI0sLE5Y2hToN0eFT/jD95ZWS/IPa4/qw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R2KPmZi5qjCl1Jady3PJJnezK+1PkvNBRGXeSG29lialAThN4gAz6/wIkrinw3AzU
	 1Pce2THCoPbL2kmkzb4FMSAiAHJIEArD4LDxVbZ77nOE5Zu/OosYaXpMksGEvbg1O4
	 XUCHeH4nOLWiMApsoUnUMMKWO/Ht+iMSayYKoqAUOEJMXcenqhPmnP0ZGue6RrKYF+
	 AiAxlbCXQ6g8EULC8ZE9p6MES7/N2a6kneEweLB6/EsEO/DIi+5yKLvZp6lD3acjjb
	 CeeplhNYIRxHVBOBjvRtnyzxnxmBq16aZPDc6f7CkQvM4lHW8VuhpjPCS/RlykiIgA
	 nefu7OpRMK6NA==
Message-ID: <25fb125b-6b4d-4f46-b8be-0a34099d1696@kernel.org>
Date: Mon, 1 Jun 2026 12:22:25 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp:export-net 15/22] include/linux/compiler_types.h:699:45:
 error: call to '__compiletime_assert_784' declared with attribute error:
 BUILD_BUG_ON failed: sizeof_field(struct mptcp_ext, flags) != sizeof(u16)
Content-Language: fr
To: oe-kbuild-all@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <202605312026.Srgsz7Tp-lkp@intel.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <202605312026.Srgsz7Tp-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi LKP team,

On 31/05/2026 23:04, kernel test robot wrote:
> tree:   https://github.com/multipath-tcp/mptcp_net-next.git export-net
> head:   27a7d32aeb103a5c763966a494b141136c31cea0
> commit: 206cf8c6e2bfce69eba0d463b3f6127d14f75abc [15/22] mptcp: fix uninit-value in mptcp_established_options
> config: arm-collie_defconfig (https://download.01.org/0day-ci/archive/20260531/202605312026.Srgsz7Tp-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260531/202605312026.Srgsz7Tp-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605312026.Srgsz7Tp-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Thank you for the report.

(...)

>    net/mptcp/options.c:576:9: note: in expansion of macro 'BUILD_BUG_ON'
>      576 |         BUILD_BUG_ON(sizeof_field(struct mptcp_ext, flags) != sizeof(u16));
>          |         ^~~~~~~~~~~~

Mmh, I wonder what size this struct group has on ARM 32bit. I tried to
reproduce the issue with the config file and the instructions, but I
didn't manage to. So I don't know what size was detected there.

  $ COMPILER_INSTALL_PATH=${HOME}/0day COMPILER=gcc-15.2.0 \
    ~/lkp/kbuild/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/mptcp/
  Compiler will be installed in ${HOME}/0day
  PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
  make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=${HOME}/0day/gcc-15.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- --jobs=32 KCFLAGS= -Wno-error=return-type -Wreturn-type -funsigned-char -Wundef -falign-functions=64 W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/mptcp/
  (...)
    CC      net/mptcp/options.o
  (...)

Any idea why I cannot reproduce the issue?

It would be good to know the output of sizeof_field().

@Paolo: or should we use memset()?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

