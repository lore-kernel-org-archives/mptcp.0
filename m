Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58109470136;
	Thu, 23 Jul 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814434; cv=none; b=QAh5Wu3WgyHSjuE+URLAc/UpHEKsOmzYEPZXQ2xIEHMAJ30X3qQJJJfoEq9qllF0jIVVamvd+D6UkWfCui76a0wY0DANTij3uxXyLWct4MctwFA/KkMyJ4wEGfacSIAogMKavQ+SIK0bqDQhuy2iMosEnegocflVmk3mGLwXB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814434; c=relaxed/simple;
	bh=TTOiuNpKd3ZCkUsJNnXQtcBfFIarUNgpz9bYK41z5To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPhnfols7Fmty+5Y7y0d1nPxx38bTEaU2UgJPdKYoMPI0S6I3wmgOHcp9NCaJGL0c/mBuJBsGqZS7RYo5+KAlVA7hN1y64Fqs0y+KB28dYi4JFzeYGEkMtz2n3X6yvKKGwWIJvjSSkaMrwwcEVIqrjkGDnEaAvYzwyindwBoDSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjuIWYOm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjuIWYOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784814430; x=1816350430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TTOiuNpKd3ZCkUsJNnXQtcBfFIarUNgpz9bYK41z5To=;
  b=mjuIWYOmzd0+XTh/J6NZ+5oeuqt3ifSmNj3cizp8bKUH6GRHMVBv61k8
   5NPr7QLBJpFEvlIy1quBAfLQ1IEMFfITrSXpgfvMmyEgEB6CndpV3z3+e
   k8BIgQW9AqPeC0apuEtf4MWuX6sgP2ROAWNF/zYbVKx9B+z659Dh5SDZh
   H/tZE/7haOKzifdtG0k028grZ8WUDtKXr1uiFZqIzdEmq1GJuyfftFOop
   If9g9YcodNa23oKuuQBArLy1OxexUCjOrDLvmkoa4tUiipo5o0AVwkVVu
   sIC/LZsDPF03ZIjUo11Q1Y097UX3/ZeYsJN8rfYWQDZLPhZ2N099Olqwe
   w==;
X-CSE-ConnectionGUID: DFquW1EVQkCCTurZoUojmg==
X-CSE-MsgGUID: 7dX0GByZRqqYrPsP4AkRpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="88008487"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="88008487"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 06:47:07 -0700
X-CSE-ConnectionGUID: 5I8g06L0RzW2DP7JqA5g0A==
X-CSE-MsgGUID: b1+2gPZ+TkuUBaWrc2aoow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="261962172"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 06:47:07 -0700
Date: Thu, 23 Jul 2026 06:47:00 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: acpica-devel@lists.linux.dev, bpf@vger.kernel.org,
	coresight@lists.linaro.org, kvm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, mptcp@lists.linux.dev,
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	virtualization@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Christian =?iso-8859-1?Q?Borntr=E4ger?= <borntraeger@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Chun-Tse Shao <ctshao@google.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	David Matlack <dmatlack@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Geliang Tang <geliang@kernel.org>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Joe Damato <joe@dama.to>,
	John Garry <john.g.garry@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Kent Gibson <warthog618@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Len Brown <lenb@kernel.org>, Leo Yan <leo.yan@linux.dev>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@arm.com>,
	Mina Almasry <almasrymina@google.com>,
	Mykyta Yatsenko <yatsenko@meta.com>, Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Song Liu <song@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Tomas Glozar <tglozar@redhat.com>,
	Vipin Sharma <vipinsh@google.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Will Deacon <will@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willy Tarreau <w@1wt.eu>, Yonghong Song <yonghong.song@linux.dev>,
	Zhang Chujun <zhangchujun@cmss.chinamobile.com>,
	Zhang Rui <rui.zhang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tools: Use fputc() calls in some functions
Message-ID: <amIbVOIsOeZgcBZF@tassilo>
References: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>

On Thu, Jul 23, 2026 at 12:25:25PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 23 Jul 2026 11:13:30 +0200
> Subject: [PATCH] tools: Use fputc() calls in some functions
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Single characters should occasionally be transferred into the output.
> Thus use the corresponding function “fputc” (or even “putchar”).
> 
> The source code was transformed by using the Coccinelle software.

gcc already does this transformation automatically.
