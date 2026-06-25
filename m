Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7292571B8;
	Thu, 25 Jun 2026 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393011; cv=none; b=PLnQb1eYSN2c+mxG/9OidYkVk5Tk2cPztmut5+Wcv3Z0qtfPntkLlU8Ve7YO4RuMr8Q780OV6AxZttNfcaGeHSXHGSgzkl0GFD5lh4YRpUdCFAwxB7KEsDBZ3Z/2GFQprFcXpFCwdFxydLiliRLF/eBFfELDi9PUObs2qjXE0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393011; c=relaxed/simple;
	bh=5cJuWCfjrqqMxsfXCZyt0HChCUUTULBse3WrMiaHxIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezL5KTSe8ktbB05/tVKDeAR1o0++P08PGFrtthw5uGl1rIv0b8Jw8TxbERg6sEUsshdTbId8fb2yZIWHi6Oi817m/p9KvD2vO28q+BrLD75FXnJ8aoP60IYZLjAFVR4jv9xLqsvJHDm/xSlnslFjHM9ICXAsLApxo94yx8tVxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOwfXTuG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOwfXTuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782393010; x=1813929010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5cJuWCfjrqqMxsfXCZyt0HChCUUTULBse3WrMiaHxIo=;
  b=GOwfXTuGw5V4iUgdZykwhMEJYCNIQ2BNiOI8FYFkpDuHtYJSrKakOGVh
   Rbtjmah+jweLebN/tikf1rgzYC9UogSzybp1GkfhLefF8R5aZ29J0GfOt
   7FhPFr8OFkL5oHlWjuHvnCw1y92OzWc17k9j9n3v6vnDlBOeZDw6aLl+h
   AEZRMjg5O1R/3EBq/SxInQ6TqAwwaOPZXL9ui4iuOzEoJX/9JqjHT1Cvo
   jgHVeDMlkxTwL6Dk3hJq+Oet7ZKCtuufP1I3oYaV+tDXn/BhGAJuBxjMW
   DVie4LkY9SPbRLrdtfKZpfcLfc13RwHPe4Ul5GOh/USp3iQAfIPrMbq/x
   g==;
X-CSE-ConnectionGUID: Y3533/eeRrW1LqJi+BgFMA==
X-CSE-MsgGUID: KFB7uumzQMWxgJl15cxs0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="85723506"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="85723506"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 06:09:59 -0700
X-CSE-ConnectionGUID: XrHWOAh4TKmmjFmAKjHcnw==
X-CSE-MsgGUID: 53a7yQG1QcmJ5CQjQRkFEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="274061755"
Received: from igk-lkp-server01.igk.intel.com (HELO igk-lkp-server01) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 25 Jun 2026 06:09:58 -0700
Received: from [10.245.245.98] (helo=frankran-MOBL)
	by igk-lkp-server01 with esmtp (Exim 4.96)
	(envelope-from <frank.ranner@intel.com>)
	id 1wcjq7-006rMF-1h;
	Thu, 25 Jun 2026 15:09:55 +0200
From: Frank Ranner <frank.ranner@intel.com>
To: matttbe@kernel.org
Cc: lkp@intel.com,
	mptcp@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	pabeni@redhat.com
Subject: Re: [mptcp:export-net 15/22] include/linux/compiler_types.h:699:45: error: call to '__compiletime_assert_784' declared with attribute error: BUILD_BUG_ON failed: sizeof_field(struct mptcp_ext, flags) != sizeof(u16)
Date: Thu, 25 Jun 2026 15:09:53 +0200
Message-ID: <20260625130953.140040-1-frank.ranner@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <d5891e2b-2f88-480f-a61e-2fe192d413ad@kernel.org>
References: <d5891e2b-2f88-480f-a61e-2fe192d413ad@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Mmh, I wonder what size this struct group has on ARM 32bit. I tried to
> reproduce the issue with the config file and the instructions, but I
> didn't manage to.

The size is 4 bytes there, and the reason is the ABI rather than the
patch itself.

arm-collie_defconfig targets the StrongARM SA1100 (ARMv4):

    CONFIG_ARCH_MULTI_V4=y
    CONFIG_ARCH_SA1100=y      # CONFIG_AEABI is not set

Because CONFIG_AEABI is not set, this config is built with the legacy ARM
ABI (APCS-GNU / OABI). Its defining difference is
-mstructure-size-boundary=32: every struct's size is rounded up to a
multiple of 4 bytes (EABI uses 8).

struct_group(flags, ...) expands flags into a named sub-struct. Under
EABI that sub-struct is 2 bytes (two u8 bitfield containers), but under OABI
it is padded up to 4 bytes. Hence:

    sizeof_field(struct mptcp_ext, flags) == 4   !=   sizeof(u16) == 2

and the new BUILD_BUG_ON in net/mptcp/options.c fires. The report is
therefore a genuine OABI portability issue, not a false positive.

The reason your local attempt passed is that the build reused an existing
O=build_dir whose .config was not the OABI collie config, so the bitfield
group packed to 2 bytes. To reproduce, regenerate the config from scratch so
the OABI flags actually take effect:

    COMPILER=gcc-15.2.0 ~/lkp/kbuild/make.cross ARCH=arm O=build_dir collie_defconfig
    COMPILER=gcc-15.2.0 ~/lkp/kbuild/make.cross W=1 ARCH=arm O=build_dir net/mptcp/options.o

Suggested fix: don't assume the flags group is exactly u16-sized. Clearing
it with

    memset(&ext->flags, 0, sizeof_field(struct mptcp_ext, flags));

instead of a 16-bit access, and dropping/relaxing the != sizeof(u16)
assertion, makes it correct on OABI too (where the group is legitimately
4 bytes).

Thanks,
Frank
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

