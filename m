Content-Type: multipart/mixed; boundary="===============0803849292191284507=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Summary of the discussion on the patch
Date: Fri, 09 Mar 2018 17:25:37 -0800
Message-ID: <alpine.OSX.2.21.1803091505350.2360@msottenb-mobl1.amr.corp.intel.com>
In-Reply-To: 17cb97ed-94dc-1d8f-47bf-475fab89de1a@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 363

--===============0803849292191284507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 9 Mar 2018, Rao Shoaib wrote:

> A few days ago I submitted a patch that implemented MPTCP using the =

> latest net-next kernel. The patch that I submitted uses the latest =

> kernel changes such as lock less listener, rb trees, resolves the long =

> standing skb issue, allows upstream to build TCP only without requiring =

> a single MPTCP file or definition, and also consolidates MPTCP code. =

> Most importantly it is based on the current net-next kernel without =

> requiring any new framework.
>
> Comments about the patch have exclusively been about the performance and =

> memory overhead of using indirect function pointers. I have repeatedly =

> solicited for any other comments. I have not received any.
>

I had some additional recommendations in =

https://lists.01.org/pipermail/mptcp/2018-February/000323.html :

"""
   * Include the new Kconfig modification to add CONFIG_MPTCP early in the =

patch set

   * Make sure that all patches will build with the config option enabled =

or disabled (all include files and symbols present, etc.)

   * Handle conditional compilation according to =

https://www.kernel.org/doc/html/latest/process/coding-style.html#conditiona=
l-compilation

   * Don't define callbacks in the data structure until there's code that =

uses them

   * Craft commit messages and subject lines that will help the reviewers =

understand the changes and what drives tham
"""

> I have since contacted David Miller and Eric Dumazet. They are not =

> allowing use of direct function pointers because of the current security =

> issues and Linux is building a new framework for such use.
>
> This is a minor change and we will be submitting a patch with the fix.
>
> When the comments about the use of indirect function pointers were made =

> I was busy and brushed them aside with one line emails. To complete the =

> discussion I think they need to be addressed with a little more =

> technical analysis. If=C2=A0 my analysis is wrong I would appreciate bein=
g =

> corrected based on technical data.
>
> Comments:
>
> * Memory bloat due to allocation of function pointer table:
>
> The function pointer tables (I believe 4) are pre-populated, are =

> __read_mostly and are shared among all sockets. The largest function =

> pointer table on my system is around 320 bytes; compare that to the size =

> of a socket which is 1024 and will get more bloated with the addition of =

> MPTCP specific data structures.
>

I agree, the size of data structures that are not per-socket or per-packet =

are not a big concern.

> * Too many indirect function pointers:
>
> I don't understand why the number even matters. What might matter is =

> their usage -- for that see below
>

The large number of pointers correlates to a large number of changes for =

all the places those functions are called. What I've seen the maintainers =

ask for is targeted, incremental changes with clear motivation. Replacing =

lots of direct function calls with calls via function pointers is a broad =

change.

> * Overhead in the fast path of regular TCP
>
> Let's evaluate a simple Rx path
>
> Rx:
>
> =C2=A0=C2=A0=C2=A0=C2=A0 one check was added in tcp_v[4,6]_rcv,
>
> =C2=A0=C2=A0=C2=A0=C2=A0 one indirect call is encountered in tcp_recv_est=
ablished or in =

> tcp_data_queue
>
> Tx:
>
> =C2=A0=C2=A0=C2=A0 Indirect call to appropriate write_xmit function and t=
han options =

> processing
>
> That's it. All other indirect function calls are used in the slow =

> control path. I may have missed counting one or two calls so in general =

> the extra overhead is two indirect function calls in the fast path. I =

> would love to see a solution with less than this overhead.
>
> Please note that these are not new calls, the original code was also =

> making a call here. The only overhead is accessing the address of the =

> table and indexing it.
>

I think expending a few clock cycles to make the TCP stack more flexible =

and better accomodate MPTCP would be a good idea, but I have a different =

set of priorities from the maintainers. What I've observed is that the =

maintainers have some rules-of-thumb for optimizing (or even =

micro-optimizing) fast paths, and converting hard-coded function calls to =

calls made with a function pointer stored in a struct is something they'll =

take a close look at on a case-by-case basis and will want to have a clear =

sense of the justification for each change.

> * Overhead of indirect function calls
>
> The example given to show the overhead was very simplistic, one that is =

> used in a beginner level assembly language course. Most modern =

> processors are very complicated, instructions are broken down into =

> multiple micro operations and are executed in parallel, add prefetching =

> and branch prediction and the whole situation becomes extremely =

> complicated. It is so irrelevant and difficult to measure the cost that =

> Intel does not even publish the cost in cycles. Perhaps Intel folks can =

> get us the difference between callq and *callq to better evaluate the =

> overhead.
>
> A similar argument applies to cache miss. Predicting a cache miss or =

> guaranteeing a cache hit for data or instruction is nearly impossible =

> except in very rare cases.
>

As I mentioned above, I think this comes down to way the maintainers look =

at performance. I'm not so much trying to justify their criteria as point =

out that these are the criteria I have observed them using. If some code =

looks less efficient to them, but really has no impact or even makes an =

improvement, I think they'll be convinced by profiling data.

> I posted the same explanation on net-dev and I have not heard otherwise =

> from anyone. As has been posted elsewhere, if indirect function calls =

> are so bad then why are they used in libraries? file system code is =

> completely based on indirect function calls.
>

I understand where you're coming from here - C function pointers are a =

staple of any non-trivial C program and are widely used throughout the =

kernel. It's unclear what they prefer instead.

David did give a technical response to your point about measureable =

overhead by saying current kernels disable optimizations for indirect =

function calls.

> * Not enough context and why indirect call for urg
>
> I thought I had provided the context in the cover letter and the code =

> changes were straight forward. If more context is needed I will be happy =

> to provide that.
>

I do think more detailed context would help. There's a need for both the =

high level overview (as in the cover letter) and information in each patch =

to justify the specific changes and provide helpful information that will =

live on in the commit history. I try to take that perspective even with =

RFCs that aren't expected to be merged.

> MPTCP currently does not have support for urgent data, TCP urgent data =

> has a particular syntax that needs to be adhered to when processing it =

> (It is common knowledge that the syntax is broken though :-)). When =

> support for urgent data is added, handling will be different than =

> regular TCP hence the separate function.
>

Ok, that's exactly the kind of information that would be very helpful in =

the commit message or comments.

> * Comparison with a different patch
>
> It was suggested that if we ask David we will look like fools because we =

> know why a previous patch was rejected -- because of the overhead due to =

> indirect function calls.
>
> If David was concerned about indirect function calls he would have given =

> the same argument as he did to my email. It seems to me that he was not =

> happy about the new checks in the fast path and indirect calls are not =

> even used in the fast path.
>
> for example in comments to patch 02/14 he says
>
> This adds a new test to the packet header building fast path,
> and all of the call sites know whether they are dealing with
> a full sock or not so the test is superfluous.
>
> And in the last comment he summarizes his concerns
>
> I can already see in your patches that new overhead is added, new
> tests in the packet building fast paths that are completely
> unnecessary with the existing code, etc.
>
> The reality is that only David knows what he was thinking, so when in =

> doubt, directly asking him does not make you look like fool. It saves =

> you a lot of time.
>

I think the core point is that the maintainers have finite time and =

attention to share. We had some suggestions, based on what maintainers =

have said in many different contexts, to iterate on the patch set to get =

the most out of the maintainer's time.

> In my email exchange on net-dev another issue over which there was =

> disagreement was also confirmed. Upstream folks will allow changes to =

> the current code; how much depends on the importance of the feature. I =

> am sure they will be very skeptical of any new framework. David added =

> that he will have to look at the change, there is no blank rule.
>

Sure, that's what I'd expect.

> I hope that I have addressed the concerns raised and explained my =

> thoughts on the design and performance. If there are any remaining =

> technical, architectural concerns please feel free to post them and we =

> will work together to resolve them.
>
> We will submit an updated patch based on the input from net-dev.

Since there are a few revisions underway, I'll take a closer look at the =

technical/architectural aspects of the code in the next posting.

Thanks,

--
Mat Martineau
Intel OTC

--===============0803849292191284507==--
