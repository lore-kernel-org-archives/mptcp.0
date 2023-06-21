Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF7174C4;
	Wed, 21 Jun 2023 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687353447; x=1718889447;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9eMWiG7JI6/9oPvFtdl/3iOGYIkGUexXwjKhm4v9hgQ=;
  b=VKdU+4JgbX4NpbUJ1pGQwx7rP4tCzihjtawrYes6gzCDNYtQiih+jwVe
   F873dwIsvhod0YARO9VKUhkj06aRarr7vuGmzoEiVQ5fk5wly5W6omK9t
   +iNA+hX6lctBvXKvd6x1QxXNWe7qto5MfagiH0EzUG6mn84V9O5UOzwoq
   F/aRtyuUwktofQl51JDVKYz5pF4rWhcdEX3XoC7ki2x3sTgM+O6J9yJog
   5JEgyf/oEuKfTSadtzoz9HPLrnTtASM+FNLftPl81nPy05SF7GnHL/9Ot
   22pUVV6zo5lB1BC+Z8d7QHj5e58COuQdxXBIR0/wXLEUCpqKND8y5XrMz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446546925"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446546925"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 06:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664658294"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664658294"
Received: from unknown (HELO localhost) ([10.237.66.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 06:15:49 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Joel Granados <j.granados@samsung.com>
Cc: mcgrof@kernel.org, Russell King <linux@armlinux.org.uk>, Catalin
	Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael
	Ellerman <mpe@ellerman.id.au>, Heiko Carstens <hca@linux.ibm.com>, Vasily
	Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Russ
	Weight <russell.h.weight@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Phillip Potter <phil@philpotter.co.uk>,
 Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, Corey
	Minyard <minyard@acm.org>, Theodore Ts'o <tytso@mit.edu>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Song Liu <song@kernel.org>, Robin Holt
 <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sudip Mukherjee
 <sudipm.mukherjee@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "James
 E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Doug Gilbert <dgilbert@interlog.com>, Jiri
	Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Benjamin
	LaHaise <bcrl@kvack.org>, David Howells <dhowells@redhat.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
	Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara
 <jack@suse.cz>, Anton Altaparmakov <anton@tuxera.com>, Mark Fasheh
 <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Kees Cook <keescook@chromium.org>, Iurii
	Zaikin <yzaikin@google.com>, Eric Biggers <ebiggers@kernel.org>, "Darrick
 J.
 Wong" <djwong@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
	Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Balbir
	Singh <bsingharora@gmail.com>, Eric Biederman <ebiederm@xmission.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 John
	Stultz <jstultz@google.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew
	Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Naoya Horiguchi
 <naoya.horiguchi@nec.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Joerg Reuter <jreuter@yaina.de>, Ralf Baechle
 <ralf@linux-mips.org>, Pablo
	Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>, Nikolay
	Aleksandrov <razor@blackwall.org>, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, Matthieu Baerts
 <matthieu.baerts@tessares.net>, Mat Martineau <martineau@kernel.org>,
 Simon
	Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, Remi
	Denis-Courmont <courmisch@gmail.com>, Santosh Shilimkar
 <santosh.shilimkar@oracle.com>, Marc Dionne <marc.dionne@auristor.com>,
 Neil
	Horman <nhorman@tuxdriver.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Karsten
 Graul <kgraul@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan
 Karcher <jaka@linux.ibm.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue
 <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>, John Johansen
 <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James
	Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jarkko
	Sakkinen <jarkko@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "H.
 Peter
 Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mike
 Travis <mike.travis@hpe.com>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Amir Goldstein <amir73il@gmail.com>,
 Matthew Bobrowski <repnop@google.com>, John Fastabend
 <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, John Ogness <john.ogness@linutronix.de>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel
	Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
 <wad@chromium.org>, Stephen Boyd <sboyd@kernel.org>, Miaohe Lin
 <linmiaohe@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-crypto@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-raid@vger.kernel.org, netdev@vger.kernel.org,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
 linux-cachefs@redhat.com, codalist@telemann.coda.cs.cmu.edu,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
 fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-hams@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux-foundation.org,
 dccp@vger.kernel.org, linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
 lvs-devel@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-afs@lists.infradead.org, linux-sctp@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org
Subject: Re: [PATCH 09/11] sysctl: Remove the end element in sysctl table
 arrays
In-Reply-To: <20230621130614.s36w4u7dzmb5d5p3@localhost>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230621091000.424843-1-j.granados@samsung.com>
 <CGME20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3@eucas1p2.samsung.com>
 <20230621094817.433842-1-j.granados@samsung.com>
 <87o7l92hg8.fsf@intel.com> <20230621130614.s36w4u7dzmb5d5p3@localhost>
Date: Wed, 21 Jun 2023 16:15:46 +0300
Message-ID: <878rcd2by5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 21 Jun 2023, Joel Granados <j.granados@samsung.com> wrote:
> On Wed, Jun 21, 2023 at 02:16:55PM +0300, Jani Nikula wrote:
>> On Wed, 21 Jun 2023, Joel Granados <j.granados@samsung.com> wrote:
>> > Remove the empty end element from all the arrays that are passed to the
>> > register sysctl calls. In some files this means reducing the explicit
>> > array size by one. Also make sure that we are using the size in
>> > ctl_table_header instead of evaluating the .procname element.
>> 
>> Where's the harm in removing the end elements driver by driver? This is
>> an unwieldy patch to handle.
>
> I totally agree. Its a big one!!! but I'm concerned of breaking bisectibility:
> * I could for example separate all the removes into separate commits and
>   then have a final commit that removes the check for the empty element.
>   But this will leave the tree in a state where the for loop will have
>   undefined behavior when it looks for the empty end element. It might
>   or might not work (probably not :) until the final commit where I fix
>   that.
>
> * I could also change the logic that looks for the final element,
>   commit that first and then remove the empty element one commit per
>   driver after that. But then for all the arrays that still have an
>   empty element, there would again be undefined behavior as it would
>   think that the last element is valid (when it is really the sentinel).
>
> Any ideas on how to get around these?

First add size to the register calls, and allow the last one to be
sentinel but do not require the sentinel.

Start removing sentinels, adjusting the size passed in.

Once enough sentinels have been removed, add warning if the final entry
is a sentinel.

Never really remove the check? (But surely you can rework the logic to
not count the number of elements up front, only while iterating.)


BR,
Jani.

>> 
>> > diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
>> > index f43950219ffc..e4d7372afb10 100644
>> > --- a/drivers/gpu/drm/i915/i915_perf.c
>> > +++ b/drivers/gpu/drm/i915/i915_perf.c
>> > @@ -4884,24 +4884,23 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
>> >  
>> >  static struct ctl_table oa_table[] = {
>> >  	{
>> > -	 .procname = "perf_stream_paranoid",
>> > -	 .data = &i915_perf_stream_paranoid,
>> > -	 .maxlen = sizeof(i915_perf_stream_paranoid),
>> > -	 .mode = 0644,
>> > -	 .proc_handler = proc_dointvec_minmax,
>> > -	 .extra1 = SYSCTL_ZERO,
>> > -	 .extra2 = SYSCTL_ONE,
>> > -	 },
>> > +		.procname = "perf_stream_paranoid",
>> > +		.data = &i915_perf_stream_paranoid,
>> > +		.maxlen = sizeof(i915_perf_stream_paranoid),
>> > +		.mode = 0644,
>> > +		.proc_handler = proc_dointvec_minmax,
>> > +		.extra1 = SYSCTL_ZERO,
>> > +		.extra2 = SYSCTL_ONE,
>> > +	},
>> >  	{
>> > -	 .procname = "oa_max_sample_rate",
>> > -	 .data = &i915_oa_max_sample_rate,
>> > -	 .maxlen = sizeof(i915_oa_max_sample_rate),
>> > -	 .mode = 0644,
>> > -	 .proc_handler = proc_dointvec_minmax,
>> > -	 .extra1 = SYSCTL_ZERO,
>> > -	 .extra2 = &oa_sample_rate_hard_limit,
>> > -	 },
>> > -	{}
>> > +		.procname = "oa_max_sample_rate",
>> > +		.data = &i915_oa_max_sample_rate,
>> > +		.maxlen = sizeof(i915_oa_max_sample_rate),
>> > +		.mode = 0644,
>> > +		.proc_handler = proc_dointvec_minmax,
>> > +		.extra1 = SYSCTL_ZERO,
>> > +		.extra2 = &oa_sample_rate_hard_limit,
>> > +	}
>> >  };
>> 
>> The existing indentation is off, but fixing it doesn't really belong in
>> this patch.
>
> Agreed. But I actually was trying to fix something that checkpatch
> flagged. I'll change these back (which will cause this patch to be
> flagged).
>
> An alternative solution would be to fix the indentation as part of the
> preparation patches. Tell me what you think.
>
> Thx
>
>> 
>> BR,
>> Jani.
>> 
>> 
>> -- 
>> Jani Nikula, Intel Open Source Graphics Center

-- 
Jani Nikula, Intel Open Source Graphics Center
